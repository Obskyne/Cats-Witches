extends CharacterBody2D

var SPEED: float = 75.0
var JUMP_VELOCITY: float = -350.0
var GRAVITY: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var camera_change: Node = %CameraChange
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera_2d: Camera2D = $Camera2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var mute: Button = %Mute
@onready var area_collision: CollisionShape2D = $"../CameraChange/Area2D3/CollisionShape2D"

func _ready() -> void:
	audio_stream_player_2d.playing = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Handles jump longevity
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y /= 2

	var direction := Input.get_axis("move_left", "move_right")
	var current_speed := SPEED * 1.6 if Input.is_action_pressed("sprint") else SPEED
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		elif direction != 0:
			animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")
	
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property(camera_2d, "zoom", Vector2(2.0, 2.0), 0.5)

func _on_area_2d_body_exited(body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property(camera_2d, "zoom", Vector2(4.0, 4.0), 0.5)

func _on_mute_toggled(toggled_on: bool) -> void:
	var bus_index = AudioServer.get_bus_index("Pre-FX")
	AudioServer.set_bus_mute(bus_index, toggled_on)# Waits 32 seconds before running the next step
	%Mute.release_focus()

func _on_area_2d_3_body_entered(_body: Node2D) -> void:
	# Instantly disable the collision shape so it cannot trigger again
	area_collision.set_deferred("disabled", true)

	var tween = create_tween()
	tween.tween_property(camera_2d, "zoom", Vector2(3.2, 3.2), 0.2)
	tween.tween_interval(39.5)
	tween.tween_property(camera_2d, "zoom", Vector2(4.0, 4.0), 0.3)

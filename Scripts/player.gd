extends CharacterBody2D

var SPEED: float = 75.0
var JUMP_VELOCITY: float = -350.0
var GRAVITY: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

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

	var direction := Input.get_axis("ui_left", "ui_right")
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

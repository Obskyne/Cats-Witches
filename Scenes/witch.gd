extends Area2D

@onready var label: RichTextLabel = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var GameManager: Node = %GameManager
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var quest_completed: bool = false
var has_talked_once: bool = false

const INITIAL_DIALOGUE = [
	{"text": "Hey, you!...", "speed": 1.0, "delay": 2.0},
	{"text": "Aww you're just a kitty...", "speed": 0.6, "delay": 4.0},
	{"text": "I would like to ask for your help in finding my lost books...", "speed": 0.5, "delay": 4.0},
	{"text": "You see... I was flying on my broomstick, exploring lands to find inspiration and finally finish writing my journal of small ideas...", "speed": 0.3, "delay": 6.0},
	{"text": "But I was being a bit... reckless while flying, and I forgot to properly secure the bag containing all my books.", "speed": 0.3, "delay": 6.0},
	{"text": "And my books were scattered throughout this small village...", "speed": 0.8, "delay": 3.0},
	{"text": "Could you do me that favor?...", "speed": 0.8, "delay": 2.5},
	{"text": "And when you come back with all my books, I'll have a reward for you... a delicious one, hehe.", "speed": 0.5, "delay": 4.0},
]

const STILL_WAITING_DIALOGUE = [
	{"text": "Still looking for the books? You need 5 in total!", "speed": 0.8, "delay": 3.0},
]

const TEST_COMPLETE_DIALOGUE = [
	{"text": "Yes! You managed to get all my books, kitty...", "speed": 1.0, "delay": 3.0},
	{"text": "Thank you very much, here is your prize...", "speed": 1.0, "delay": 3.0},
]

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player") or quest_completed:
		return

	if GameManager.score >= 5:
		quest_completed = true
		await run_dialogue(body, TEST_COMPLETE_DIALOGUE)
		get_tree().change_scene_to_file("res://Scenes/victory.tscn")
	elif not has_talked_once:
		has_talked_once = true
		await run_dialogue(body, INITIAL_DIALOGUE)
		start_cooldown(40.0)
	else:
		run_dialogue(body, STILL_WAITING_DIALOGUE)

func start_cooldown(seconds: float) -> void:
	# set_deferred is required when disabling collision inside physics callbacks
	collision_shape_2d.set_deferred("disabled", true)
	await get_tree().create_timer(seconds).timeout
	collision_shape_2d.set_deferred("disabled", false)

func run_dialogue(player: Node2D, sequence: Array) -> void:
	player.set_physics_process(false)
	if "velocity" in player:
		player.velocity = Vector2.ZERO

	for line in sequence:
		animation_player.speed_scale = line["speed"]
		animation_player.play("dialogue")
		label.text = line["text"]
		
		await get_tree().create_timer(line["delay"]).timeout
		
		animation_player.play("RESET")
		await get_tree().create_timer(1.0).timeout

	player.set_physics_process(true)

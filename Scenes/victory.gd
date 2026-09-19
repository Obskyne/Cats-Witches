extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("skdlhjfgdiklsufgheorsiklfg")
	await get_tree().create_timer(6).timeout
	animation_player.play_backwards("skdlhjfgdiklsufgheorsiklfg")
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")

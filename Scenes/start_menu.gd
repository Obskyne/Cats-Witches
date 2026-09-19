extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var start_timer: Timer = $StartTimer
@onready var exit_timer: Timer = $ExitTimer

func _on_jugar_pressed() -> void:
	animation_player.play("fadeout")
	start_timer.start()
	

func _on_salir_pressed() -> void:
	OS.shell_open("https://linktr.ee/obskynemusic")


func _on_start_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_exit_timer_timeout() -> void:
	get_tree().quit()


func _on_keybinds_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/keybind_menu.tscn")

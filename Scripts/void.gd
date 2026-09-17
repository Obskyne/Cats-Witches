extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(_body: Node2D) -> void:
	timer.start()
	print("You Died")


func _on_timer_timeout() -> void:
	print("Bitch")
	get_tree().reload_current_scene()

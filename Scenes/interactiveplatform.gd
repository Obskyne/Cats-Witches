extends AnimatableBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var has_been_triggered: bool = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if has_been_triggered:
		return

	has_been_triggered = true
	print("yea")
	animation_player.play("interactiveplatform")

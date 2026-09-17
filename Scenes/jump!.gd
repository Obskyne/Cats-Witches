extends Label


func _ready() -> void:
	modulate.a = 0.0


func _on_area_2d_body_entered(_body: Node2D) -> void:
	var tween := create_tween()
	tween.tween_interval(0.0) # Starts inmideatly
	tween.tween_property(self, "modulate:a", 1.0, 0.8)
	tween.tween_interval(2.5)
	tween.tween_property(self, "modulate:a", 0.0, 0.8)
	tween.tween_callback(queue_free)

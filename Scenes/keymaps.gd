extends Label

func _ready() -> void:
	modulate.a = 0.0

	var tween := create_tween()
	tween.tween_interval(1.5)
	tween.tween_property(self, "modulate:a", 1.0, 0.8)
	tween.tween_interval(5.0)
	tween.tween_property(self, "modulate:a", 0.0, 0.8)
	tween.tween_callback(queue_free)

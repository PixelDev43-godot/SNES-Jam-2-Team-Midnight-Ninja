extends AnimatedSprite2D

func _process(delta: float) -> void:
	if Global.level >= 2:
		self.visible = false
func _on_timer_timeout() -> void:
	print("timer ended")
	self.visible = false

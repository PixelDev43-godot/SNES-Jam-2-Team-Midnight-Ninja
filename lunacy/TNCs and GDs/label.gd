extends Label

var speed = 7.5

func _process(delta: float) -> void:
	position.y -= speed * delta

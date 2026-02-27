extends Camera2D

@export var random_strength: float = 30.0
@export var shake_fade = 5.0
var shake_strength = 0.0
var rng = RandomNumberGenerator.new()
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0.0, shake_fade * delta)
		offset = random_offset()
func apply_shake(strength: float):
	shake_strength = strength

func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))

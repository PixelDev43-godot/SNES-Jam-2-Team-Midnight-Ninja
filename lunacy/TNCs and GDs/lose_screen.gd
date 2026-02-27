extends Control

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	# Only handle input types that actually have a 'pressed' property
	if (event is InputEventKey or event is InputEventMouseButton or event is InputEventJoypadButton) and event.pressed:
		var level_scene = "res://TNCs and GDs/level_%d.tscn" % Global.level
		get_tree().call_deferred("change_scene_to_file", level_scene)

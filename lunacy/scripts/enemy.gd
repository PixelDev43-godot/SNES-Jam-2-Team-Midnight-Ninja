extends Node2D

var speed = 20.0
func _physics_process(delta: float) -> void:
	var target_pos: Vector2
	var players = get_tree().get_nodes_in_group("player_group")

	if players [0].radius_d == 0.0:
		target_pos = players [0].box_d.global_position
	else:
		target_pos = players [0].box_a.global_position
	var direction = target_pos - global_position
	
	global_position += direction.normalized() * speed * delta
	

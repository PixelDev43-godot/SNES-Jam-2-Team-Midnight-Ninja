extends Node2D

@onready var timer: Timer = $EnemyShape/Timer

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
	



	


func _on_timer_timeout() -> void:
	self.queue_free()




func _on_area_2d_area_entered(area: Area2D) -> void:
	$EnemyShape/AnimatedSprite2D.play("blow up")
	speed = 1
	$Timer.start()


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	$EnemyShape/AnimatedSprite2D.play("blow up")
	speed = 1
	timer.start()




func _on_player_area_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	$EnemyShape/AnimatedSprite2D.play("blow up")
	speed = 1
	timer.start()

extends CharacterBody2D



var one_attacking = false
var two_attacking = true
var rotatations_s = 0.5

@export var attack_visuals = true
@onready var animation: AnimatedSprite2D = $animation
@onready var animation_2: AnimatedSprite2D = $"../BoxAttack/Animation2"

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("p-swap"):
			one_attacking = !one_attacking
			two_attacking = !two_attacking
			attack_visuals = !attack_visuals
	
	if attack_visuals:
		$BoxVisuals.modulate = Color.ORANGE
	else:
		$BoxVisuals.modulate = Color.BLUE
	move_and_slide()
	check_pit_collision()
	check_pit_collision_two()
				
func _on_area_one_area_entered(area: Area2D) -> void:
		if area.is_in_group("enemy_group"):
			if one_attacking:
				area.get_parent().queue_free()
				get_parent().enemy_down()
			else:
				get_tree().call_deferred("change_scene_to_file", "res://scenes/lose_screen.tscn")
		elif area.is_in_group("hurt"):
			get_tree().call_deferred("change_scene_to_file", "res://scenes/lose_screen.tscn")
		elif area.is_in_group("winner"):
			get_tree().change_scene_to_file("res://scenes/win_screen.tscn")



func _on_area_two_area_entered(area: Area2D) -> void:
		if area.is_in_group("enemy_group"):
			if two_attacking:
				area.get_parent().queue_free()
				get_parent().enemy_down()
			else:
				get_tree().call_deferred("change_scene_to_file", "res://scenes/lose_screen.tscn")
		elif area.is_in_group("hurt"):
			get_tree().call_deferred("change_scene_to_file", "res://scenes/lose_screen.tscn")
		elif area.is_in_group("winner"):
			get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
func check_pit_collision():
	var a_one = get_node_or_null("AreaOne")
	if a_one:
		var overlap = a_one.get_overlapping_areas()
		for area in overlap:
			if area.is_in_group("pit"):
				if one_attacking:
					pass
				else:
					get_tree().call_deferred("change_scene_to_file", "res://scenes/lose_screen.tscn")
func check_pit_collision_two():
	var a_two = get_node_or_null("AreaTwo")
	if a_two:	
		var overlap = a_two.get_overlapping_areas()
		for area in overlap:
			if area.is_in_group("pit"):
				if two_attacking:
					pass
				else:
					get_tree().call_deferred("change_scene_to_file", "res://scenes/lose_screen.tscn")


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	animation.play("lose")
	print("oh no")
	$"animation timer".start()




func _on_animation_timer_timeout() -> void:
	print("should work")
	get_tree().call_deferred("change_scene_to_file", "res://TNCs and GDs/lose_screen.tscn")


func _on_pit_collision_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if one_attacking:
		pass
	else:
		animation.play("fall")
		print("ahhhhhhhh")
		$"animation timer".start()


func _on_wall_collision_2_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	animation_2.play("lose")
	print("oh no")
	$"animation timer".start()


func _on_pit_collision_2_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if one_attacking:
		pass
	else:
		animation_2.play("fall")
		print("ahhhhhhhh")
		$"animation timer".start()

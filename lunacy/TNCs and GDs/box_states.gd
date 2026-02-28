extends CharacterBody2D



var one_attacking = false
var two_attacking = true
var rotatations_s = 0.5
var pit = false
var pit2 = false
var can_die = true
@export var attack_visuals = true
@onready var animation: AnimatedSprite2D = $animation
@onready var animation2: AnimatedSprite2D = $Animation2



func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("p-swap") and pit2:
		if can_die:
			animation.play("fall")
			$"animation timer".start()
			can_die = false
	
	if Input.is_action_just_pressed("p-swap") and pit:
		if can_die:
			animation.play("fall")
			$"animation timer".start()
			can_die = false
	
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
				await get_tree().create_timer(1.0).timeout
				if is_instance_valid(area):
					area.get_parent().queue_free()
				get_parent().enemy_down()
			else:
				$"animation timer".start()
				animation.play("lose")
		elif area.is_in_group("hurt"):
			get_tree().call_deferred("change_scene_to_file", "res://TNCs and GDs/lose_screen.tscn")
		elif area.is_in_group("winner"):
			get_tree().change_scene_to_file("res://scenes/win_screen.tscn")



func _on_area_two_area_entered(area: Area2D) -> void:
		print(" help me")
		if area.is_in_group("enemy_group"):
			print("why wont this work?")
			if two_attacking:
				await get_tree().create_timer(1.0).timeout
				if is_instance_valid(area):
					area.get_parent().queue_free()
				get_parent().enemy_down()
				print("why wont this work?")
			else:
				$"animation timer".start()
				animation2.play("lose")
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


func _on_wall_collision_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	animation.play("lose")
	print("oh no")
	$"animation timer".start()




func _on_animation_timer_timeout() -> void:
	print("should work")
	get_tree().call_deferred("change_scene_to_file", "res://TNCs and GDs/lose_screen.tscn")

func _on_pit_collision_2_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pit = false
		

	
func _on_wall_collision_2_area_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	animation2.play("lose")
	print("oh no")
	$"animation timer".start()
	


func _on_pit_collision_2_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if $pit_collision_2.get_overlapping_bodies().size() > 0:
		pit2 = true
		print(pit2)
	else:
		pit2 = false
		print(pit2)


func _on_wall_collision_2_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	animation2.play("lose")
	print("hehe")
	$"animation timer".start()


func _on_pit_collision_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if $pit_collision.get_overlapping_bodies().size() > 0:
		pit = true
		print(pit)
	else:
		pit = false
		print(pit)

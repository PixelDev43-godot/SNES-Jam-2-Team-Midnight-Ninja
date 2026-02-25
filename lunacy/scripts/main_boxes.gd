extends Node2D

var angle = 0.0
var rotation_speed = 3.0
var target_rotation_speed = -3.0
var pivot_point = Vector2(100, 100)
@onready var is_attack = true
var radius_d = 0.0    
var radius_a = 32
var radius_lenghth = 0
@onready var box_d = $BoxDefend
@onready var box_a = $BoxAttack
var enemy_count = 20
@onready var reverse = false
var slow_down_delta = 0.05

func _physics_process(delta):
	if reverse:
		target_rotation_speed = -3.0
	else:
		target_rotation_speed = 3.0
	rotation_speed = lerp(rotation_speed, target_rotation_speed, slow_down_delta)
	angle += rotation_speed * delta
	if radius_d != 0:	
		box_d.global_position = get_rotated_pos(pivot_point, radius_d + radius_lenghth, angle)
	else:
		box_d.global_position = get_rotated_pos(pivot_point, radius_d, angle)
	if radius_a != 0:
		box_a.global_position = get_rotated_pos(pivot_point, radius_a + radius_lenghth, angle)
	else:
		box_a.global_position = get_rotated_pos(pivot_point, radius_a, angle)
	if is_attack:
		$Camera.global_position = box_d.global_position
	else:
		$Camera.global_position = box_a.global_position
	if Input.is_action_just_pressed("p-swap"):
		swap_pivots()
		is_attack = !is_attack
	if Input.is_action_just_pressed("reverse"):
		reverse = !reverse
	if Input.is_action_pressed("lengthen"):
		if radius_lenghth <= 32:
			target_rotation_speed += 1
			radius_lenghth += 0.5
	if Input.is_action_pressed("shorten"):
		if radius_lenghth >= 0:
			target_rotation_speed -= 1
			radius_lenghth -= 0.5
func get_rotated_pos(pivot: Vector2, radius: float, theta: float) -> Vector2:
	var x = pivot.x + (radius * cos(theta))
	var y = pivot.y + (radius * sin(theta))
	return Vector2(x, y)


func swap_pivots():
	angle += PI
	if is_attack:
		radius_a = 0.0
		radius_d = 32.0
		pivot_point = box_a.global_position
	else:
		radius_a = 32.0
		radius_d = 0.0	
		pivot_point = box_d.global_position

func enemy_down():
	enemy_count -= 1
	

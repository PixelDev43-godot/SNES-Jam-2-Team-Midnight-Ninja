extends CharacterBody2D

var move_distance := 48
var can_swap := true

@onready var timer: Timer = $Timer

func _physics_process(delta):
	rotate(0.07)

	# Detect platform velocity
	var platform_velocity := Vector2.ZERO
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		var collider = col.get_collider()
		if collider.is_in_group("moving_platform"):
			platform_velocity = collider.velocity

	# Apply platform movement
	global_position += platform_velocity * delta

	# Your original movement
	if Input.is_action_pressed("swap") and can_swap:
		var forward = Vector2.UP.rotated(rotation)
		global_position += forward * move_distance

		rotation += PI
		can_swap = false
		timer.start()

func _on_timer_timeout() -> void:
	can_swap = true

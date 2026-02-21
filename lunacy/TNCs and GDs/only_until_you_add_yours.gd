extends CharacterBody2D

var move_distance := 50
var can_swap := true

@onready var timer: Timer = $Timer

func _physics_process(delta):
	rotate(0.1)

	if Input.is_action_pressed("swap") and can_swap:
		var forward = Vector2.UP.rotated(rotation)
		global_position += forward * move_distance

		# Rotate a full 180 degrees
		rotation += PI

		can_swap = false
		timer.start()

func _on_timer_timeout() -> void:
	can_swap = true

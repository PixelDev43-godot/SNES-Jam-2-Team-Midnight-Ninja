extends Node2D

var music
var choice: bool
var on = false

@onready var lunacy_sped_up: AudioStreamPlayer2D = $"lunacy sped up"
@onready var infestation: AudioStreamPlayer2D = $infestation


func _ready():
	choice = [true, false].pick_random()
	print("Choice is: ", choice)

func _on_music_collider_2_body_exited(body: Node2D) -> void:
	on = false


func _on_infestation_finished() -> void:
	if on:
		choice = [true, false].pick_random()
		if choice == true:
			infestation.play()
		else:
			lunacy_sped_up.play()


func _on_lunacy_sped_up_finished() -> void:
		if on:
			choice = [true, false].pick_random()
			if choice == true:
				infestation.play()
			else:
				lunacy_sped_up.play()


func _on_music_colider_2_area_entered(area: Area2D) -> void:
	on = true
	infestation.play()


func _on_music_colider_2_area_exited(area: Area2D) -> void:
	on = false
	infestation.stop()
	lunacy_sped_up.stop()

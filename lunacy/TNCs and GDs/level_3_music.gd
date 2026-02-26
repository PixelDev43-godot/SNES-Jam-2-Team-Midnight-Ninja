extends Node2D

var music
var choice: bool
var on = false

@onready var lunacy_theme_low: AudioStreamPlayer2D = $lunacy_theme_low
@onready var lunacy_theme: AudioStreamPlayer2D = $"lunacy theme"

func _physics_process(delta):
	if on == false:
		lunacy_theme_low.stop()
		lunacy_theme.stop()

func _ready():
	choice = [true, false].pick_random()
	print("Choice is: ", choice)


func _on_lunacy_theme_low_finished() -> void:
	if on:
		choice = [true, false].pick_random()
		if choice == true:
			lunacy_theme_low.play()
		else:
			lunacy_theme.play()


func _on_lunacy_theme_finished() -> void:
		if on:
			choice = [true, false].pick_random()
			if choice == true:
				lunacy_theme.play()
			else:
				lunacy_theme_low.play()


func _on_music_colider_3_area_entered(area: Area2D) -> void:
	on = true
	lunacy_theme_low.play()


func _on_music_colider_3_area_exited(area: Area2D) -> void:
	on = false
	lunacy_theme.stop()
	lunacy_theme_low.stop()

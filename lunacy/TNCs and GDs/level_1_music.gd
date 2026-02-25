extends Node2D

var music
var choice: bool
var on: bool = true

@onready var lunacy_theme: AudioStreamPlayer2D = $"lunacy theme"
@onready var lunacy_flute: AudioStreamPlayer2D = $"lunacy flute"

func _ready():
	choice = [true, false].pick_random()
	print("Choice is: ", choice)

func _physics_process(delta):
	if on == false:
		lunacy_flute.stop()
		lunacy_theme.stop()

func _on_lunacy_theme_finished() -> void:
	if on:
		choice = [true, false].pick_random()
		if choice == true:
			lunacy_theme.play()
		else:
			lunacy_flute.play()


func _on_lunacy_flute_finished() -> void:
	if on:
		choice = [true, false].pick_random()
		if choice == true:
			lunacy_theme.play()
		else:
			lunacy_flute.play()


func _on_music_collider_1_area_exited(area: Area2D) -> void:
	on = false

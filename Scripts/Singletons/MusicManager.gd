extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	play_music()

func play_music():
	$Music.play()
	pass

func play_sound(sound : String):
	find_child(sound).play()

func play_sound_pitched(sound : String):
	find_child(sound).pitch_scale = randf_range(0.7,1.3)
	find_child(sound).play()

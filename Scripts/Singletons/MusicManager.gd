extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_music():
	$Music.play()

func play_sound(sound : String):
	find_child(sound).play()

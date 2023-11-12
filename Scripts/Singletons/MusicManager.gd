extends Node

var music_mode : String = "MenuMusic"

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("state_changed", _on_state_change)
	play_music()

func play_music():
	$MenuMusic.stream_paused = true
	$GameMusic.stream_paused = true
	find_child(music_mode).play(0)
	pass

func play_sound(sound : String):
	find_child(sound).play()

func play_sound_pitched(sound : String):
	find_child(sound).pitch_scale = randf_range(0.7,1.3)
	find_child(sound).play()

func _on_state_change():
	if music_mode == "MenuMusic" and (GameManager.current_state == GameManager.GameState.Tutorial or GameManager.current_state == GameManager.GameState.Playing):
		music_mode = "GameMusic"
		play_music()
	elif music_mode == "GameMusic" and GameManager.current_state ==  GameManager.GameState.Menu:
		music_mode = "MenuMusic"
		play_music()

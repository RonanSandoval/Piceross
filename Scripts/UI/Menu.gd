extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.set_game_state(GameManager.GameState.Menu)

func _process(delta):
	if Input.is_action_just_pressed("freeze"):
		GameManager.game_progress = 10
		SceneManager.change_scene("res://Scenes/LevelSelect.tscn")

extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.set_game_state(GameManager.GameState.Menu)

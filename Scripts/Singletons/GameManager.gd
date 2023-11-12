extends Node

enum GameState {Menu, Playing, Win, Lose, Loading, Tutorial}
var current_state : GameState = GameState.Playing
signal state_changed

var game_progress : int
var current_level : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_game_state(to_state : GameState):
	current_state = to_state
	print(current_state)
	state_changed.emit()

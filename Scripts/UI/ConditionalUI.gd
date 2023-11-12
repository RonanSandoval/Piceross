extends Control

@export var my_state : GameManager.GameState

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("state_changed", _check_state_change)
	visible = false

func _check_state_change():
	if GameManager.current_state == my_state:
		visible = true
	else:
		visible = false

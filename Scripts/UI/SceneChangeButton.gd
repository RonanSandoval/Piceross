extends TextureRect

@export var to_scene : String 

var turn : float = 0
var turning : bool = false

func _process(delta):
	if turning:
		rotation_degrees = cos(turn) * 2
		turn += delta * 3
	else:
		rotation_degrees = 0

func _on_mouse_entered():
	turning = true


func _on_mouse_exited():
	turning = false


func _on_gui_input(event):
	if event is InputEventMouseButton and GameManager.current_state != GameManager.GameState.Loading:
		SceneManager.change_scene(to_scene)
		MusicManager.play_sound("button")

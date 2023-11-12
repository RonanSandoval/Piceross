extends TextureRect

signal next_page

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
	if event is InputEventMouseButton and Input.is_action_just_pressed("break") and GameManager.current_state != GameManager.GameState.Loading:
		next_page.emit()
		MusicManager.play_sound("button")
	
		

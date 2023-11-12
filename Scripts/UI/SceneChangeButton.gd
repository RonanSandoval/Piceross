extends TextureRect

@export var to_scene : String 

func _on_mouse_entered():
	modulate = Color(1.2, 1.2, 1.2, 1)


func _on_mouse_exited():
	modulate = Color(1, 1, 1, 1)


func _on_gui_input(event):
	if event is InputEventMouseButton and GameManager.current_state != GameManager.GameState.Loading:
		SceneManager.change_scene(to_scene)

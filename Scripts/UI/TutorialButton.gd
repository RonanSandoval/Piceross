extends TextureRect

signal next_page

func _on_mouse_entered():
	modulate = Color(1.2, 1.2, 1.2, 1)


func _on_mouse_exited():
	modulate = Color(1, 1, 1, 1)


func _on_gui_input(event):
	if event is InputEventMouseButton and Input.is_action_just_pressed("break") and GameManager.current_state != GameManager.GameState.Loading:
		next_page.emit()
	
		

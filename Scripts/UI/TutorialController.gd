extends Control

var current_page : int = 0
var total_pages : int

# Called when the node enters the scene tree for the first time.
func _ready():
	total_pages = $Pages.get_child_count()
	if total_pages > 0:
		GameManager.set_game_state(GameManager.GameState.Tutorial)
	else:
		GameManager.set_game_state(GameManager.GameState.Playing)
		queue_free()
	
	$ProceedButton.connect("next_page", _on_next_page)
	show_page()

func show_page():
	for index in range(total_pages):
		$Pages.get_child(index).visible = index == current_page
	
func _on_next_page():
	current_page += 1
	if current_page < total_pages:
		show_page()
	else:
		queue_free()
		GameManager.set_game_state(GameManager.GameState.Playing)

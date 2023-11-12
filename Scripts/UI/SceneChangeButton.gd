extends TextureRect

@export var to_scene : String 
@export var progress_dependent : bool
@export var progress_num : int

var is_ready : bool = true

var turn : float = 0
var turning : bool = false

func _ready():
	if progress_dependent and GameManager.game_progress < progress_num:
		material = null
		modulate = Color(0,0,0,0.5)
		is_ready = false

func _process(delta):
	if turning:
		rotation_degrees = cos(turn) * 2
		turn += delta * 3
	else:
		rotation_degrees = 0

func _on_mouse_entered():
	if is_ready:
		turning = true


func _on_mouse_exited():
	turning = false


func _on_gui_input(event):
	if is_ready and event is InputEventMouseButton and GameManager.current_state != GameManager.GameState.Loading:
		SceneManager.change_scene(to_scene)
		MusicManager.play_sound("button")

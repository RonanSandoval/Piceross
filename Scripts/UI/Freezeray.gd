extends TextureRect

signal freeze

const LOAD_TIME : float = 2

var current_load : float = 0
var is_ready : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$ProgressBar.value = LOAD_TIME


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("freeze") and is_ready:
		use_freeze()
	
	if not is_ready:
		current_load -= delta
		update_progress()
		if current_load <= 0:
			is_ready = true
			modulate = Color(1,1,1,1)


func update_progress():
	$ProgressBar.value = LOAD_TIME - current_load

func use_freeze():
	MusicManager.play_sound("freeze")
	is_ready = false
	current_load = LOAD_TIME
	modulate = Color(0.5, 0.5, 0.5, 1)
	freeze.emit()

func _on_mouse_entered():
	if is_ready:
		modulate = Color(1.2, 1.2, 1.2, 1)


func _on_mouse_exited():
	if is_ready:
		modulate = Color(1, 1, 1, 1)

func _on_gui_input(event):
	if  is_ready and event is InputEventMouseButton and GameManager.current_state == GameManager.GameState.Playing:
		use_freeze()

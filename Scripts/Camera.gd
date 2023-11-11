extends Camera3D

@export var player_node : Node3D

const SMOOTHING : float = 0.1
var CAMERA_CENTER : Vector3

var osscilate : float = 0

var camera_mode : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("state_changed", show_top_down)
	var game_width = get_parent().find_child("Nonogram").NONOGRAM_WIDTH
	var game_height = get_parent().find_child("Nonogram").NONOGRAM_HEIGHT
	CAMERA_CENTER = Vector3(game_width / 2, 0, game_height/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	osscilate += delta
	
	if camera_mode == 0:
		var destination = player_node.position.lerp(CAMERA_CENTER, 0.2)
		position = Vector3( lerp(position.x, destination.x, SMOOTHING),
							6 + (cos(osscilate) / 20),
							lerp(position.z, destination.z + 2, SMOOTHING))
	elif camera_mode == 1:
		position = Vector3( lerp(position.x, CAMERA_CENTER.x, SMOOTHING),
							lerp(position.y, 15 + (cos(osscilate) / 20), SMOOTHING),
							lerp(position.z, CAMERA_CENTER.z + 2, SMOOTHING))
		rotation_degrees.x = lerp(rotation_degrees.x, -90.0, SMOOTHING)

func show_top_down():
	camera_mode = 1

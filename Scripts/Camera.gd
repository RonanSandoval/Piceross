extends Camera3D

@export var player_node : Node3D

const SMOOTHING : float = 0.2
const CAMERA_CENTER : Vector3 = Vector3(5, 0, 5)

var osscilate : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var destination = player_node.position.lerp(CAMERA_CENTER, 0.2)
	osscilate += delta
	position = Vector3( lerp(position.x, destination.x, SMOOTHING),
						6 + (cos(osscilate) / 10),
						lerp(position.z, destination.z + 2, SMOOTHING))

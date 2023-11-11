extends CSGBox3D

const TURN_INTENSITY : float = 0.05
const MOVE_INTENSITY : float = 0.02

var x_speed : float
var x_inc : float
var z_speed : float
var z_inc : float
var turn_speed : float
var turn_inc : float

# Called when the node enters the scene tree for the first time.
func _ready():
	x_speed = randf_range(1,2)
	z_speed = randf_range(1,2)
	turn_speed = randf_range(0.1,0.7)
	x_inc = randf_range(0,10)
	z_inc = randf_range(0,10)
	turn_inc = randf_range(0,10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	x_inc += delta * x_speed
	z_inc += delta * z_speed
	turn_inc += delta * turn_speed
	
	position.x = cos(x_inc) * MOVE_INTENSITY
	position.z = cos(z_inc) * MOVE_INTENSITY
	rotation.y = cos(turn_inc) * TURN_INTENSITY

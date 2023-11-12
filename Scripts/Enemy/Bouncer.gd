extends Enemy

@export var X_AVG : float
@export var Z_AVG : float

var x_velocity : float
var x_dir : int = 1
var z_velocity : float
var z_dir : int = 1

func _ready():
	super()
	x_velocity = X_AVG
	z_velocity = Z_AVG

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		translate(Vector3(x_velocity * x_dir * delta, 0, z_velocity * z_dir * delta))
		
		if position.x < -0.5 or position.x > 9.5:
			position.x = clamp(position.x, -0.5, 9.5)
			x_dir *= -1
			x_velocity = X_AVG * randf_range(0.8, 1.2)
			$Sprite3D.flip_h = x_dir < 0
		if position.z < -0.5 or position.z > 9.5:
			position.z = clamp(position.z, -0.5, 9.5)
			z_dir *= -1
			z_velocity = X_AVG * randf_range(0.8, 1.2)
		

extends StaticBody3D

@export var ice_material : Material
@export var ice_hover_material : Material 
@export var ice_range_material : Material 

var in_range : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_input_event(camera, event, position, normal, shape_idx):
	if event.is_action_pressed("break") and in_range:
		queue_free()


func _on_mouse_entered():
	if in_range:
		$IceShape.material_override = ice_hover_material


func _on_mouse_exited():
	if in_range:
		$IceShape.material_override = ice_range_material

func set_in_range(value : bool):
	in_range = value
	if in_range:
		$IceShape.material_override = ice_range_material
	else:
		$IceShape.material_override = ice_material

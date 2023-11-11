extends StaticBody3D

@export var ice_material : Material
@export var ice_hover_material : Material 
@export var ice_range_material : Material 
@export var ice_range_hover_material : Material 
@export var ice_destroyed_material : Material
@export var ice_destroyed_range_material : Material

var in_range : bool = false

var marked : bool = false
var destroyed : bool = false

var my_y : int
var my_x : int

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_parent().get_parent().find_child("Freezeray").connect("freeze", on_freeze)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_input_event(camera, event, position, normal, shape_idx):
	if event.is_action_pressed("break") and in_range and not marked:
		get_parent().get_parent().break_slot(my_x, my_y)
		$IceShape.material_override = ice_destroyed_range_material
		$IceCollision.disabled = true
		destroyed = true
	if event.is_action_pressed("mark") and in_range and not destroyed:
		if marked:
			get_parent().get_parent().unmark_slot(my_x, my_y)
			marked = false
			$Marker.visible = false
		else:
			get_parent().get_parent().mark_slot(my_x, my_y)
			marked = true
			$Marker.visible = true
		

func on_freeze():
	if in_range and destroyed:
		destroyed = false
		get_parent().get_parent().unbreak_slot(my_x, my_y)
		$IceCollision.disabled = false
		$IceShape.material_override = ice_range_material
		

func _on_mouse_entered():
	if not destroyed:
		if in_range:
			$IceShape.material_override = ice_range_hover_material
		else:
			$IceShape.material_override = ice_hover_material
		


func _on_mouse_exited():
	if not destroyed:
		if in_range:
			$IceShape.material_override = ice_range_material
		else:
			$IceShape.material_override = ice_material

func set_in_range(value : bool):
	in_range = value
	if not destroyed:
		if in_range:
			$IceShape.material_override = ice_range_material
		else:
			$IceShape.material_override = ice_material
	else:
		if in_range:
			$IceShape.material_override = ice_destroyed_range_material
		else:
			$IceShape.material_override = ice_destroyed_material

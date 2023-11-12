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
	await get_tree().create_timer(0.1).timeout
	if get_parent().get_parent().get_slot(my_y, my_x) == 1:
		$IceCollision.call_deferred("set_disabled", true)
		destroyed = true
		$IceShape.material_override = ice_destroyed_material


func _on_input_event(camera, event, position, normal, shape_idx):
	if event.is_action_pressed("break") and in_range:
		break_ice()
	if event.is_action_pressed("mark") and in_range and not destroyed:
		MusicManager.play_sound_pitched("mark")
		if marked:
			unmark()
		else:
			get_parent().get_parent().mark_slot(my_x, my_y)
			marked = true
			$Marker.visible = true
		

func break_ice():
	if not destroyed and not marked:
		get_parent().get_parent().break_slot(my_x, my_y)
		if not in_range:
			$IceShape.material_override = ice_destroyed_material
		else:
			$IceShape.material_override = ice_destroyed_range_material
		$IceCollision.call_deferred("set_disabled", true)
		destroyed = true
		MusicManager.play_sound_pitched("break")
		$GPUParticles3D.emitting = true

func unmark():
	get_parent().get_parent().unmark_slot(my_x, my_y)
	marked = false
	$Marker.visible = false

func on_freeze():
	if in_range and destroyed:
		$GPUParticles3D.emitting = true
		destroyed = false
		get_parent().get_parent().unbreak_slot(my_x, my_y)
		$IceCollision.call_deferred("set_disabled", false)
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

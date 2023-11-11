extends Node

var ice_scene : PackedScene = preload("res://Scenes/Prefabs/ice.tscn")

const ICE_SEP : float = 1.1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset_board():
	for z_index in range(get_parent().NONOGRAM_HEIGHT):
		for x_index in range(get_parent().NONOGRAM_WIDTH):
			place_ice(x_index , z_index)

func place_ice(x : int, z : int):
	var ice_instance : Node = ice_scene.instantiate()
	add_child(ice_instance)
	ice_instance.position.x = x  * ICE_SEP
	ice_instance.position.z = z  * ICE_SEP
	ice_instance.my_x = x
	ice_instance.my_y = z

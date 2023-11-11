extends Node

var ice_scene : PackedScene = preload("res://Scenes/Prefabs/ice.tscn")

const ICE_SEP : float = 1.1

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_board()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset_board():
	for z_index in range($Nonogram.NONOGRAM_HEIGHT):
		for x_index in range($Nonogram.NONOGRAM_WIDTH):
			place_ice(x_index * ICE_SEP , z_index * ICE_SEP)

func place_ice(x : float, z : float):
	var ice_instance : Node = ice_scene.instantiate()
	add_child(ice_instance)
	ice_instance.position.x = x
	ice_instance.position.z = z

extends Node

var hint_scene : PackedScene = preload("res://Scenes/Prefabs/hint.tscn")

@export var hint_sprites : Array[Texture]

func spawn_hints():
	for row_index in range(get_parent().NONOGRAM_HEIGHT):
		var hint_array : Array = get_parent().get_hints("row", row_index)
		hint_array.reverse()
		for hint_index in range(hint_array.size()):
			place_hint(-1.5 - hint_index, row_index * 1.1, hint_array[hint_index])
	
	for column_index in range(get_parent().NONOGRAM_WIDTH):
		var hint_array : Array = get_parent().get_hints("column", column_index)
		hint_array.reverse()
		for hint_index in range(hint_array.size()):
			place_hint(column_index * 1.1, -1.5 - hint_index, hint_array[hint_index])


func place_hint(x : float, z : float, value : int):
	var hint_instance : Node = hint_scene.instantiate()
	add_child(hint_instance)
	hint_instance.position.x = x
	hint_instance.position.z = z
	hint_instance.texture = hint_sprites[value]

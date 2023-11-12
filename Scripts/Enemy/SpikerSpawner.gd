extends Node

@export var WAIT_TIME : float

var spiker_scene : PackedScene = preload("res://Scenes/Prefabs/spiker.tscn")

var current_wait : float
var active : bool = true

var nonogram_node : Node

func _ready():
	current_wait = WAIT_TIME
	GameManager.connect("state_changed", _on_state_change)
	nonogram_node = get_parent().get_parent().find_child("Nonogram")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		current_wait -= delta
		
		if current_wait <= 0:
			current_wait = WAIT_TIME
			look_for_slot()


func look_for_slot():
	for index in range(50):
		print('lookin')
		var my_x = randi_range(0,9)
		var my_z = randi_range(0,9)
		if nonogram_node.get_slot(my_z, my_x) == 2:
			var spiker_instance = spiker_scene.instantiate()
			get_parent().call_deferred("add_child", spiker_instance)
			spiker_instance.position = Vector3(my_x * 1.1, 0.4, my_z * 1.1)
			spiker_instance.my_x = my_x
			spiker_instance.my_z = my_z
			return

func _on_state_change():
	active = GameManager.current_state == GameManager.GameState.Playing

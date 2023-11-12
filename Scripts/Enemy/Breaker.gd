extends Enemy

@export var MOVE_TIME : float
@export var WAIT_TIME : float

var nonogram_node : Node

enum EnemyState {Waiting, Moving, Breaking}
var current_state : EnemyState = EnemyState.Waiting

var curr_location : Vector3
var destination : Vector3
var move_counter : float

func _ready():
	nonogram_node = get_parent().get_parent().find_child("Nonogram")
	connect("area_entered", _on_area_entered)
	super()
	curr_location = position
	waiting()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		if current_state == EnemyState.Moving:
			position = curr_location.lerp(destination, move_counter / MOVE_TIME)
			move_counter += delta
			
			if move_counter >= MOVE_TIME:
				position = destination
				curr_location = destination
				move_counter = 0
				current_state = EnemyState.Breaking
		if current_state == EnemyState.Breaking:
			translate(Vector3(0, -1 * delta, 0))
		if current_state == EnemyState.Waiting and position.y < 1:
			translate(Vector3(0, delta, 0))
		

func look_for_slot():
	for index in range(50):
		var my_x = randi_range(0,9)
		var my_z = randi_range(0,9)
		if nonogram_node.get_slot(my_z, my_x) == 0:
			return Vector3(my_x * 1.1, 1, my_z * 1.1)
	return null

func waiting():
	while true:
		await get_tree().create_timer(WAIT_TIME).timeout
		var next_slot = look_for_slot()
		if next_slot != null:
			destination = next_slot
			current_state = EnemyState.Moving
			return

func _on_area_entered(area : Area3D):
	if current_state == EnemyState.Breaking and area.name == "IceHit":
		current_state = EnemyState.Waiting
		area.get_parent().break_ice()
		waiting()

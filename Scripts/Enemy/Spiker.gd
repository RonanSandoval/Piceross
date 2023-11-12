extends Enemy

const INCUBATION_PERIOD : float = 3

var nonogram_node : Node

var incubation_time : float
var incubating : bool

var my_x : int
var my_z : int

func _ready():
	super()
	nonogram_node = get_parent().get_parent().find_child("Nonogram")
	nonogram_node.connect("slot_broken", _on_slot_broken)
	incubation_time = INCUBATION_PERIOD
	incubating = true
	active = true
	$CollisionShape3D.disabled = true
	$Sprite3D.animation = "hibernate"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		if incubating:
			incubation_time -= delta
			if incubation_time < 0:
				incubating = false
				$CollisionShape3D.call_deferred("set_disabled", false)
				$Sprite3D.call_deferred("set_animation", "alive")
				MusicManager.play_sound("spiked")

func _on_slot_broken():
	print(nonogram_node.get_slot(my_x, my_z))
	if nonogram_node.get_slot(my_z, my_x) == 1:
		queue_free()


func _on_area_entered(area):
	if area.name == "IceHit":
		area.get_parent().unmark()

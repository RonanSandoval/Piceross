extends Sprite3D

@export var follow_node : Node

func _ready():
	position.y = 0.16

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_instance_valid(follow_node):
		position.x = follow_node.position.x
		position.z = follow_node.position.z
	else:
		queue_free()

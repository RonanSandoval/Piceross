extends Sprite3D

@export var follow_node : Node

func _ready():
	position.y = 0.16
	print("shadow")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = follow_node.position.x
	position.z = follow_node.position.z

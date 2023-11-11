extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.name == "IceHit":
		area.get_parent().set_in_range(true)


func _on_area_exited(area):
	if area != null and area.name == "IceHit":
		area.get_parent().set_in_range(false)

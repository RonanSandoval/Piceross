extends Sprite3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var camera_pos = get_owner().find_child("Camera3D").position
	look_at(camera_pos, Vector3(0, 1, 0))

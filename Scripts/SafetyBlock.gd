extends StaticBody3D

func _ready():
	var game_width = get_parent().find_child("Nonogram").NONOGRAM_WIDTH
	var game_height = get_parent().find_child("Nonogram").NONOGRAM_HEIGHT
	position = Vector3(game_width / 2 * 1.1, 0, game_height * 1.1 + 0.5)

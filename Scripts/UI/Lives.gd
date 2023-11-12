extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_parent().get_parent().find_child("Player").connect("life_lost", update_hearts)

func update_hearts(lives : int):
	for i in range(5):
		get_child(i).visible = i < lives
	

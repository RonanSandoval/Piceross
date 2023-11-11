extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_parent().find_child("Player").connect("life_lost", update_hearts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_hearts(lives : int):
	print(lives)
	for i in range(5):
		get_child(i).visible = i < lives
	

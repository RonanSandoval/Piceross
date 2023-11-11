extends Node

var nonogram : Array = [[]]
var answer : Array = [[]]

const NONOGRAM_HEIGHT : int = 10
const NONOGRAM_WIDTH : int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_nonogram()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset_nonogram() -> void:
	var inner_array = []
	inner_array.resize(NONOGRAM_WIDTH)
	inner_array.fill(0)
	
	nonogram.resize(NONOGRAM_HEIGHT)
	nonogram.fill(inner_array)
	
	print(nonogram)
	
func break_slot(x : int, y : int) -> void:
	nonogram[x][y] = 1
	
func mark_slot(x : int, y : int) -> void:
	nonogram[x][y] = 2
	
func get_hints(type : String, index : int) -> Array:
	var hints : Array = []
	var curr_count : int = 0
	
	if type == "row":
		for slot in answer[index]:
			if slot == 1:
				curr_count += 1
			elif curr_count > 0:
				hints.append(curr_count)
				curr_count = 0
				
	elif type == "column":
		for row in answer:
			if row[index] == 1:
				curr_count += 1
			elif curr_count > 0:
				hints.append(curr_count)
				curr_count = 0
	
	if curr_count > 0:
		hints.append(curr_count)
	
	return hints

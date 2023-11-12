extends Node

@export var puzzle_index : int

var nonogram : Array = [[]]
var answer : Array = [[]]

@export var NONOGRAM_HEIGHT : int
@export var NONOGRAM_WIDTH : int 

signal slot_broken

func _ready():
	prepare_nonogram()
	$IceSpawner.reset_board()
	$Hints.spawn_hints()

# Called when the node enters the scene tree for the first time.
func prepare_nonogram():
	reset_nonogram()
	read_puzzle_json()
	read_starts_json()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print("------------------------------")
		for row in nonogram: 
			print(row)

func reset_nonogram() -> void:
	var inner_array = []
	inner_array.resize(NONOGRAM_WIDTH)
	inner_array.fill(0)
	
	nonogram.resize(NONOGRAM_HEIGHT)
	for index in nonogram.size():
		nonogram[index] = inner_array.duplicate()
	
func break_slot(x : int, y : int) -> void:
	nonogram[y][x] = 1
	slot_broken.emit()
	check_puzzle()

func unbreak_slot(x : int, y : int) -> void:
	nonogram[y][x] = 0
	check_puzzle()
	
func mark_slot(x : int, y : int) -> void:
	nonogram[y][x] = 2

func unmark_slot(x : int, y : int) -> void:
	if nonogram[y][x] == 2:
		nonogram[y][x] = 0
	
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
	
	if hints.size() == 0:
		hints.append(0)
	
	return hints
	
func read_puzzle_json() -> void:
	var file = FileAccess.open("res://Resources/nonograms.json", FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	var finish = json.parse_string(content)
	answer = finish["nonograms"][puzzle_index]

func read_starts_json() -> void:
	var file = FileAccess.open("res://Resources/starts.json", FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	var finish = json.parse_string(content)
	nonogram = finish["starts"][puzzle_index]

func check_puzzle():
	for y in range(NONOGRAM_HEIGHT):
		for x in range(NONOGRAM_WIDTH):
			if answer[y][x] == 0 and not (nonogram[y][x] == 0 or nonogram[y][x] == 2):
				return false
			if answer[y][x] == 1 and not nonogram[y][x] == 1:
				return false
	GameManager.set_game_state(GameManager.GameState.Win)
	return true	

func get_slot(x : int, z : int) -> int:
	return nonogram[x][z]


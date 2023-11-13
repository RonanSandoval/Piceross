extends CharacterBody3D

var safety_scene : PackedScene = preload("res://Scenes/Prefabs/safetyblock.tscn")
var game_width : int
var game_height : int


var lives : int = 8
signal life_lost(lives_left)

var dead : bool = false
var paused : bool = false

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	game_width = get_parent().find_child("Nonogram").NONOGRAM_WIDTH
	game_height = get_parent().find_child("Nonogram").NONOGRAM_HEIGHT
	spawn()

func _physics_process(delta):
	if GameManager.current_state == GameManager.GameState.Playing and not dead:
		if not is_on_floor():
			velocity.y -= gravity * delta

		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not paused:
			MusicManager.play_sound_pitched("jump")
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction and not paused:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
			if direction.x != 0:
				$PlayerSprite.flip_h = direction.x < 0
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
			
		#fell
		if position.y < -1 and not dead:
			MusicManager.play_sound("fall")
			lose_life()

		move_and_slide()
	
func lose_life():
	lives -= 1
	life_lost.emit(lives)
	dead = true
	visible = false
	if lives <= 0:
		GameManager.set_game_state(GameManager.GameState.Lose)
	else:
		await get_tree().create_timer(0.5).timeout
		spawn()

func spawn():
	position = Vector3(game_width / 2 * 1.1, 1, game_height * 1.1)
	dead = false
	visible = true

func _input(event):
	if GameManager.current_state == GameManager.GameState.Playing:
		if  Input.is_key_pressed(KEY_SHIFT):
			paused = true
		else:
			paused = false

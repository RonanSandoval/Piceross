extends CharacterBody3D

var lives : int = 5
signal life_lost(lives_left)

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	if GameManager.current_state == GameManager.GameState.Playing:
		if not is_on_floor():
			velocity.y -= gravity * delta

		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
			
		#fell
		if position.y < -1:
			lose_life()

		move_and_slide()

func reset_position():
	position = Vector3(5, 1, 5)
	
func lose_life():
	lives -= 1
	life_lost.emit(lives)
	if lives <= 0:
		GameManager.set_game_state(GameManager.GameState.Lose)
	else:
		reset_position()

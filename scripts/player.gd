extends CharacterBody3D


const BASE_SPEED = 5
const JUMP_VELOCITY = 7

var speed: float

@onready var _camera_pivot: Node3D = $CameraPivot

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle running
	if Input.is_action_pressed("run"):
		speed = BASE_SPEED * 2
	else:
		speed = BASE_SPEED

	# Get the input direction and handle the movement/deceleration
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	# Correct the input direction based on the camera's rotation
	input_dir = input_dir.rotated(-1 * _camera_pivot.rotation.y)
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func _process(delta: float) -> void:
	# Handle camera rotation
	if Input.is_action_pressed("ui_left"):
		_camera_pivot.rotation.y += deg_to_rad(90) * delta
	elif Input.is_action_pressed("ui_right"):
		_camera_pivot.rotation.y -= deg_to_rad(90) * delta
	_camera_pivot.rotation.y = wrapf(_camera_pivot.rotation.y, -PI, PI)
	print("Camera rotation: ", rad_to_deg(_camera_pivot.rotation.y))
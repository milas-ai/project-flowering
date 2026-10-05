extends Node
class_name PlayerInput


const DEGREES_PER_UNIT: float = 0.001

signal jump_pressed
signal push_pressed
signal stun_pressed

@onready var _camera_pivot: Node3D = $"../CameraPivot"

var h_input_dir = Vector2.ZERO
var running: bool = false
var sliding: bool = false
var camera_rotation: float = deg_to_rad(45)
var mouse_sensitivity: int = 2


func _ready() -> void:
	Input.set_use_accumulated_input(false)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		return
	
	if event is InputEventKey:
		if event.is_action_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			mouse_rotate(event)

func _process(_delta: float) -> void:
	h_input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	h_input_dir = h_input_dir.rotated(-1 * _camera_pivot.rotation.y)
	
	running = Input.is_action_pressed("run")
	sliding = Input.is_action_pressed("slide")

	if $CameraRotationCooldown.time_left == 0:
		if Input.is_action_pressed("ui_left"):
			$CameraRotationCooldown.start()
			camera_rotation -= deg_to_rad(90)
		elif Input.is_action_pressed("ui_right"):
			$CameraRotationCooldown.start()
			camera_rotation += deg_to_rad(90)
	else:
		_camera_pivot.rotation.y = lerp_angle(_camera_pivot.rotation.y, camera_rotation, 0.1)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_just_pressed("jump"):
			jump_pressed.emit()
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("push"):
			push_pressed.emit()
	if event is InputEventKey:
		if Input.is_action_just_pressed("stun"):
			stun_pressed.emit()

func mouse_rotate(event: InputEventMouseMotion) -> void:
	var viewport_transform = get_tree().root.get_final_transform()
	var mouse_motion = event.xformed_by(viewport_transform).relative
	
	_camera_pivot.rotate_y(-mouse_motion.x * mouse_sensitivity * DEGREES_PER_UNIT)
class_name PlayerInput
extends Node


const MOUSE_DEGREES_PER_UNIT: float = 0.0002
const JOYSTICK_DEGREES_PER_UNIT: float = 0.001

signal jump_pressed
signal push_pressed
signal stun_pressed
signal block_pressed
signal block_released

var h_input_dir := Vector2.ZERO
var running: bool = false
var sliding: bool = false

@onready var _camera_pivot: Node3D = $"../CameraPivot"
@onready var _main_game: MainGame = $/root/MainGame


func _ready() -> void:
	Input.set_use_accumulated_input(false)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			_mouse_rotate(event)

	if Input.is_action_just_pressed("jump"):
		jump_pressed.emit()
	if Input.is_action_just_pressed("push"):
		push_pressed.emit()
	if Input.is_action_just_pressed("stun"):
		stun_pressed.emit()
	if Input.is_action_just_pressed("block"):
		block_pressed.emit()
	if Input.is_action_just_released("block"):
		block_released.emit()


func _process(_delta: float) -> void:
	h_input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	h_input_dir = h_input_dir.rotated(-_camera_pivot.rotation.y)
	
	running = Input.is_action_pressed("run")
	sliding = Input.is_action_pressed("slide")

	if Input.get_connected_joypads().size() > 0:
		_joystick_rotate(Input.get_joy_axis(0, JOY_AXIS_RIGHT_X))


func _mouse_rotate(event: InputEventMouseMotion) -> void:
	var viewport_transform: Transform2D = get_tree().root.get_final_transform()
	var mouse_motion: Vector2 = event.xformed_by(viewport_transform).relative
	
	_camera_pivot.rotate_y(
			-mouse_motion.x *
			_main_game.options.camera_sensitivity *
			_main_game.options.pixelization_level *
			MOUSE_DEGREES_PER_UNIT
	)


func _joystick_rotate(axis_value: float) -> void:
	_camera_pivot.rotate_y(
		-axis_value *
		_main_game.options.camera_sensitivity *
		_main_game.options.pixelization_level *
		JOYSTICK_DEGREES_PER_UNIT
	)

extends Node
class_name PlayerInput


signal jump_pressed

var h_input_dir = Vector2.ZERO
var running: bool = false

@onready var _camera_pivot: Node3D = $"../CameraPivot"


func _process(_delta: float) -> void:
	h_input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	h_input_dir = h_input_dir.rotated(-1 * _camera_pivot.rotation.y)
	
	running = Input.is_action_pressed("run")


func _input(event: InputEvent) -> void:
	# Emits signals on events
	# Keyboard
	if event is InputEventKey:
		if Input.is_action_just_pressed("jump"):
			jump_pressed.emit()

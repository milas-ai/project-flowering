class_name StatePlayerMove
extends State


var _speed: float = BaseStat.PLAYER.SPEED
var _is_running: bool = false


func enter() -> void:
	if _is_running:
		body.animation_player.play("Run")
	else:
		body.animation_player.play("Walk")


func update(delta: float) -> void:
	if _is_running:
		body.animation_player.play("Run")
		body.process_horizontal_movement(delta, body.input_direction, _speed * 2)
	else:
		body.animation_player.play("Walk")
		body.process_horizontal_movement(delta, body.input_direction, _speed)

	if body.input_direction.length() < 0.1:
		state_machine.transition_to("StatePlayerIdle")


func exit() -> void:
	_speed = BaseStat.PLAYER.SPEED


func start_running() -> void:
	_is_running = true


func stop_running() -> void:
	_is_running = false

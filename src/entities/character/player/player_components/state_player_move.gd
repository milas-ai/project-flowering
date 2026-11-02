class_name StatePlayerMove
extends State


var _speed: float = BaseStat.PLAYER.SPEED


func enter() -> void:
	if state_machine.running_pressed:
		body.animation_player.play("Run")
	else:
		body.animation_player.play("Walk")


func update(delta: float) -> void:
	body.process_rotation(false)
	if state_machine.running_pressed:
		body.animation_player.play("Run")
		body.process_horizontal_movement(delta, body.input_direction, _speed * 2)
	else:
		body.animation_player.play("Walk")
		body.process_horizontal_movement(delta, body.input_direction, _speed)

	if body.input_direction.length() < 0.1:
		state_machine.transition_to("StatePlayerIdle")
	if body.vertical_velocity.y < 0:
		state_machine.transition_to("StatePlayerFall")


func exit() -> void:
	_speed = BaseStat.PLAYER.SPEED

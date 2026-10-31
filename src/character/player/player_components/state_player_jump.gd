class_name StatePlayerJump
extends State


func enter() -> void:
	body.animation_player.play("Jump")
	body.vertical_velocity.y = BaseStat.PLAYER.JUMP_VELOCITY

func update(delta: float) -> void:
	if body.vertical_velocity.y <= 0:
		state_machine.transition_to("StatePlayerFall")

	body.process_horizontal_movement(delta, body.input_direction, BaseStat.PLAYER.SPEED)
	body.process_rotation(false)


func exit() -> void:
	pass

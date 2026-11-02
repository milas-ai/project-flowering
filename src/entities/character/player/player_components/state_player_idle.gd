class_name StatePlayerIdle
extends State


func enter() -> void:
	body.animation_player.play("Idle")


func update(delta: float) -> void:
	if body.vertical_velocity.y < 0:
		state_machine.transition_to("StatePlayerFall")
	if body.input_direction.length() > 0.1:
		state_machine.transition_to("StatePlayerMove")
	body.process_horizontal_movement(delta, Vector3.ZERO, BaseStat.PLAYER.SPEED)


func exit() -> void:
	pass

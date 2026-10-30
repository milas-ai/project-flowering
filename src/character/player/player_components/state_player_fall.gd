class_name StatePlayerFall
extends State


func enter() -> void:
	body.animation_player.play("Fall")


func update(delta: float) -> void:
	if body.vertical_velocity.y >= 0:
		state_machine.transition_to("StatePlayerIdle")
		
	body.process_horizontal_movement(delta, BaseStat.PLAYER.SPEED)


func exit() -> void:
	pass

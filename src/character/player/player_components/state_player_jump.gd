class_name StatePlayerJump
extends State


func enter() -> void:
	body.animation_player.play("Jump")
	body.vertical_velocity.y = BaseStat.PLAYER.JUMP_VELOCITY


func update(_delta: float) -> void:
	if body.vertical_velocity.y < 0:
		state_machine.transition_to("StatePlayerFall")


func exit() -> void:
	pass

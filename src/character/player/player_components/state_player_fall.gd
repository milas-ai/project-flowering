class_name StatePlayerFall
extends State


func enter() -> void:
	body.animation_player.play("Fall")


func update(_delta: float) -> void:
	if body.vertical_velocity.y >= 0:
		state_machine.transition_to("StatePlayerIdle")


func exit() -> void:
	pass

class_name StatePlayerIdle
extends State


func enter() -> void:
	body.animation_player.play("Idle")


func update(_delta: float) -> void:
	if body.vertical_velocity.y < 0:
		state_machine.transition_to("StatePlayerFall")


func exit() -> void:
	pass

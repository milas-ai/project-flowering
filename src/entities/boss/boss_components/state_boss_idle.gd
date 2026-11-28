class_name StateBossIdle
extends State


func enter() -> void:
	body.animation_player.play_backwards("hit")
	await body.animation_player.animation_finished
	state_machine.transition_to("StateBossAttack")


func update(_delta: float) -> void:
	pass


func exit() -> void:
	pass

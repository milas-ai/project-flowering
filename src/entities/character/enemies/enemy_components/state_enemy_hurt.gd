class_name StateEnemyHurt
extends State


func enter() -> void:
	body.animation_player.play("hurt")
	await body.animation_player.animation_finished
	state_machine.transition_to("StateEnemyIdle")


func update(_delta: float) -> void:
	pass


func exit() -> void:
	pass

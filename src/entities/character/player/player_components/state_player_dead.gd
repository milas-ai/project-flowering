class_name StatePlayerDead
extends State


func enter() -> void:
	body.animation_player.play("Hit")


func update(_delta: float) -> void:
	pass


func exit() -> void:
	pass

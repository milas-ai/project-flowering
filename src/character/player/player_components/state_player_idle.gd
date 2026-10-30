class_name StatePlayerIdle
extends State


func enter() -> void:
	body.animation_player.play("Idle")


func update(_delta: float) -> void:
	pass


func exit() -> void:
	pass

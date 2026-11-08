class_name StateEnemyDead
extends State


func enter() -> void:
	body.animation_player.play("death")
	await body.animation_player.animation_finished
	body.queue_free()


func update(_delta: float) -> void:
	pass


func exit() -> void:
	pass

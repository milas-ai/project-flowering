class_name StateEnemyDead
extends State


func enter() -> void:
	body.look_at(body.player.global_transform.origin, Vector3.UP)
	body.animation_player.play("dead")
	await body.animation_player.animation_finished
	body.queue_free()


func update(_delta: float) -> void:
	pass


func exit() -> void:
	pass

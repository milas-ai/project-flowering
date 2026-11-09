class_name StateEnemyDead
extends State


func enter() -> void:
	body.look_at(body.player.global_transform.origin, Vector3.UP)
	body.animation_player.play("dead")
	await body.animation_player.animation_finished
	ParticleSystem.play(ParticleID.RAISE_DUST, body.global_transform.origin + Vector3(0, 0.5, 0))
	body.queue_free()


func update(_delta: float) -> void:
	pass


func exit() -> void:
	pass

class_name StateBossDead
extends State


func enter() -> void:
	body.animation_player.play("die")
	ParticleSystem.play(ParticleID.HEMOLYMPH_SPLASH, body.head_marker.global_transform.origin)
	body.flash_material()
	await body.animation_player.animation_finished
	ParticleSystem.play(ParticleID.RAISE_DUST, body.head_marker.global_transform.origin + Vector3.DOWN * 0.5)
	body.boss_dead.emit()


func update(_delta: float) -> void:
	pass


func exit() -> void:
	pass

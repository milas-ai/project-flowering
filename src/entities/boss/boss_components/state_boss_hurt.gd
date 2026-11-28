class_name StateBossHurt
extends State


func enter() -> void:
	body.animation_player.play("hit")
	ParticleSystem.play(ParticleID.HEMOLYMPH_SPLASH, body.head_marker.global_transform.origin)
	body.flash_material()
	await body.animation_player.animation_finished
	body.boss_hurt.emit()


func update(_delta: float) -> void:
	pass


func exit() -> void:
	pass

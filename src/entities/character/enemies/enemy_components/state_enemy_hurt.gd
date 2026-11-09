class_name StateEnemyHurt
extends State


func enter() -> void:
	body.animation_player.clear_queue()
	body.look_at(body.player.global_transform.origin, Vector3.UP)
	body.animation_player.play("hurt")
	ParticleSystem.play(ParticleID.HEMOLYMPH_SPLASH, body.global_transform.origin)
	_flash_material()
	await body.animation_player.animation_finished
	state_machine.transition_to("StateEnemyIdle")


func update(_delta: float) -> void:
	pass


func exit() -> void:
	pass


func _flash_material() -> void:
	var flash_duration: float = 0.067
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

	tween.tween_property(body.material, "emission_energy_multiplier", 1.0, flash_duration)
	tween.tween_property(body.material, "emission_energy_multiplier", 0.0, flash_duration)
	tween.tween_property(body.material, "emission_energy_multiplier", 1.0, flash_duration)
	tween.tween_property(body.material, "emission_energy_multiplier", 0.0, flash_duration)

class_name StatePlayerDead
extends State


func enter() -> void:
	body.animation_player.play("Die")
	get_tree().create_timer(2.0).timeout.connect(
			func() -> void:
				var position: Vector3 = body.global_position + Vector3(0, 0.5, 0)
				# Offset the particle effect to match where the player is falling
				position -= body.forward_direction * 0.67
				ParticleSystem.play(ParticleID.RAISE_DUST, position))


func update(delta: float) -> void:
	body.process_horizontal_movement(delta, Vector3.ZERO, BaseStat.PLAYER.SPEED)


func exit() -> void:
	pass

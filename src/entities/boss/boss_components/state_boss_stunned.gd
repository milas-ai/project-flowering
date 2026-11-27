class_name StateBossStunned
extends State


@onready var _stun_particle_emmitter: int = ParticleSystem.instantiate_emitter(ParticleID.STUN_STAR, Vector3.ZERO)
@onready var _stun_marker: Marker3D = $"../../Markers/StunMarker"


func enter() -> void:
	body.animation_player.stop()
	body.animation_player.play("stunned")
	ParticleSystem.restart_emitter(_stun_particle_emmitter)
	ParticleSystem.trigger_emitter(_stun_particle_emmitter, _stun_marker.global_transform.origin)

	get_tree().create_timer(BaseStat.BOSS.STUN_DURATION).timeout.connect(
			func():
				if state_machine.get_current_state() == "StateBossStunned":
					state_machine.transition_to("StateBossAttack"))


func update(_delta: float) -> void:
	pass


func exit() -> void:
	ParticleSystem.hide_emitter(_stun_particle_emmitter)
	body.animation_player.play("RESET")

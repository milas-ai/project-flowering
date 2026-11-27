class_name Boss
extends StaticBody3D


var _stunned: bool = false

@onready var _animation_player: AnimationPlayer = $CharacterModel/AnimationPlayer
@onready var _stun_particle_emmitter: int = ParticleSystem.instantiate_emitter(ParticleID.STUN_STAR, global_transform.origin)
@onready var _stun_marker: Marker3D = $StunMarker


func _ready() -> void:
	_animation_player.play("spider_fire")


func apply_stun() -> void:
	if _stunned:
		return

	_stunned = true
	_animation_player.play("spider_idle")
	ParticleSystem.restart_emitter(_stun_particle_emmitter)
	ParticleSystem.trigger_emitter(_stun_particle_emmitter, _stun_marker.global_transform.origin)

	get_tree().create_timer(BaseStat.BOSS.STUN_DURATION).timeout.connect(
			func():
				if _stunned:
					_stunned = false
					ParticleSystem.hide_emitter(_stun_particle_emmitter)
					_animation_player.stop())


func take_damage(damage: int) -> void:
	if not _stunned:
		return
	
	ParticleSystem.hide_emitter(_stun_particle_emmitter)
	_animation_player.play("spider_hurt")
	await _animation_player.animation_finished
	hide()
	_stunned = false
	print("Boss took damage: %d" % damage)

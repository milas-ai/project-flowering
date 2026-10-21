extends State
class_name StateStunned


@export var stun_duration: float = 3.0

@onready var _stun_marker: Marker3D = $"../../StunMarker"


func enter() -> void:
	body.horizontal_velocity = Vector3.ZERO
	body.animation_player.stop()
	ParticleSystem.play(ParticleID.STUN_STAR, _stun_marker.global_transform.origin)

	get_tree().create_timer(stun_duration).timeout.connect(func(): state_machine.transition_to("StateIdle"))


func update(_delta: float) -> void:
	body.horizontal_velocity = Vector3.ZERO


func exit() -> void:
	pass

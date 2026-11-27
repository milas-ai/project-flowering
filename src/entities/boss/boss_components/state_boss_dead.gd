class_name StateBossDead
extends State


@onready var _head_marker: Marker3D = $"../../Markers/HeadMarker"


func enter() -> void:
	body.animation_player.play("dead")
	await body.animation_player.animation_finished
	ParticleSystem.play(ParticleID.RAISE_DUST, _head_marker.global_transform.origin + Vector3.DOWN * 0.5)


func update(_delta: float) -> void:
	pass


func exit() -> void:
	pass

class_name StateBossHurt
extends State


@onready var _head_marker: Marker3D = $"../../Markers/HeadMarker"


func enter() -> void:
	body.animation_player.clear_queue()
	body.animation_player.play("hit")
	ParticleSystem.play(ParticleID.HEMOLYMPH_SPLASH, _head_marker.global_transform.origin)
	_flash_material()
	await body.animation_player.animation_finished
	body.hide()
	body.process_mode = Node3D.PROCESS_MODE_DISABLED


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

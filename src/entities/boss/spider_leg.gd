class_name SpiderLeg
extends Node3D


signal smashed_stone

@onready var _animation_player: AnimationPlayer = $Model/AnimationPlayer
@onready var _material: StandardMaterial3D = $Model/Armature/Skeleton3D/Cylinder_001.get_active_material(0)


func stomp() -> void:
	_animation_player.play("stomp")


func reset() -> void:
	_animation_player.play("RESET")
	await _animation_player.animation_finished


func _on_stomp_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(BaseStat.BOSS.STOMP_DAMAGE)
	elif body is BossArenaStone:
		body.explode()
		_flash_material()
		emit_signal("smashed_stone")


func _flash_material() -> void:
	var flash_duration: float = 0.067
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

	tween.tween_property(_material, "emission_energy_multiplier", 1.0, flash_duration)
	tween.tween_property(_material, "emission_energy_multiplier", 0.0, flash_duration)
	tween.tween_property(_material, "emission_energy_multiplier", 1.0, flash_duration)
	tween.tween_property(_material, "emission_energy_multiplier", 0.0, flash_duration)

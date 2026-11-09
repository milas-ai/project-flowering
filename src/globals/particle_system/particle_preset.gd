class_name ParticlePreset
extends Node3D


@export var id: StringName

@onready var _animation_player: AnimationPlayer = get_node_or_null("AnimationPlayer")


func run_once(time: float = 2.0) -> void:
	emit()
	get_tree().create_timer(time).timeout.connect(queue_free)


func emit() -> void:
	if _animation_player:
		_animation_player.play("emit")
	else:
		for child in get_children():
			if child is GPUParticles3D:
				child.emitting = true


func stop_emission() -> void:
	if _animation_player:
		_animation_player.stop()
	else:
		for child in get_children():
			if child is GPUParticles3D:
				child.emitting = false

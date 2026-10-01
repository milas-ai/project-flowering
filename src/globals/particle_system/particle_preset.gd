extends Node3D
class_name ParticlePreset


@export var id: StringName


func run_effect(time: float = 2.0):
	for child in get_children():
		if child is GPUParticles3D:
			child.emitting = true
	get_tree().create_timer(time).timeout.connect(queue_free)

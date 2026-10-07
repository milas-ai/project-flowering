class_name ParticlePreset
extends Node3D


@export var id: StringName

@onready var _animation_player: AnimationPlayer = $AnimationPlayer


func run_effect(time: float = 2.0) -> void:
	if _animation_player:
		_animation_player.play("emit")
	else:
		for child in get_children():
			if child is GPUParticles3D:
				child.emitting = true
	get_tree().create_timer(time).timeout.connect(queue_free)

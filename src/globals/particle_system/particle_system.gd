extends Node


@export var database: ParticleDatabase

var _particle_dictionary: Dictionary = {}

@onready var _effect_root: Node3D = $/root/MainGame.get_node("%EffectRoot")


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for preset in database.particles:
		_particle_dictionary[ preset.get_state().get_node_property_value(0,1) ] = preset


func play(particle_id: String, position: Vector3, rotation: Vector3 = Vector3.ZERO, time: float = 2.0) -> void:
	var particle: ParticlePreset = _spawn_particle(particle_id, position, rotation)
	if particle:
		particle.run_effect(time)


func _spawn_particle(particle_id: String, position: Vector3, rotation: Vector3 = Vector3.ZERO) -> ParticlePreset:
	var particle_scene: PackedScene = _particle_dictionary.get(particle_id)
	if particle_scene:
		var particle_instance: ParticlePreset = particle_scene.instantiate()
		_effect_root.add_child(particle_instance)
		particle_instance.global_transform.origin = position
		particle_instance.global_rotation = rotation
		return particle_instance
	return null
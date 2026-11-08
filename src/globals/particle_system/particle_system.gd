extends Node


@export var database: ParticleDatabase

var _particle_dictionary: Dictionary = {}
var _emitter_dictionary: Dictionary = {}

@onready var _effect_root: Node3D = $/root/MainGame.get_node("%EffectRoot")


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for preset in database.particles:
		_particle_dictionary[ preset.get_state().get_node_property_value(0,1) ] = preset


func play(particle_id: String, position: Vector3, rotation: Vector3 = Vector3.ZERO, time: float = 2.0) -> void:
	var particle: ParticlePreset = _spawn_particle(particle_id, position, rotation)
	if particle:
		particle.run_once(time)


func instantiate_emitter(particle_id: String, position: Vector3, rotation: Vector3 = Vector3.ZERO) -> int:
	var particle: ParticlePreset = _spawn_particle(particle_id, position, rotation)
	if particle:
		var index: int = _emitter_dictionary.size()
		_emitter_dictionary[index] = particle
		return index
	return -1


func start_emitter(index: int) -> void:
	var particle: ParticlePreset = _emitter_dictionary.get(index)
	particle.emit()


func stop_emitter(index: int) -> void:
	var particle: ParticlePreset = _emitter_dictionary.get(index)
	particle.stop_emission()


func remove_emitter(index: int) -> void:
	var particle: ParticlePreset = _emitter_dictionary.get(index)
	particle.queue_free()
	_emitter_dictionary.erase(index)


func _spawn_particle(particle_id: String, position: Vector3, rotation: Vector3 = Vector3.ZERO) -> ParticlePreset:
	var particle_scene: PackedScene = _particle_dictionary.get(particle_id)
	if particle_scene:
		var particle_instance: ParticlePreset = particle_scene.instantiate()
		_effect_root.add_child(particle_instance)
		particle_instance.global_transform.origin = position
		particle_instance.global_rotation = rotation
		return particle_instance
	return null

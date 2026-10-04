extends Node


@export var database: ParticleDatabase

var particle_dictionary = {}


func _ready() -> void:
	for preset in database.particles:
		particle_dictionary[ preset.get_state().get_node_property_value(0,1) ] = preset

func play(particle_id: String, position: Vector3, rotation: Vector3 = Vector3.ZERO, time: float = 2.0):
	var particle_scene = particle_dictionary.get(particle_id)
	if particle_scene:
		var particle_instance = particle_scene.instantiate()
		get_tree().current_scene.add_child(particle_instance)
		particle_instance.global_transform.origin = position
		particle_instance.global_rotation = rotation
		particle_instance.run_effect(time)

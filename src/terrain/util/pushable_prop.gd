class_name PushableProp
extends RigidBody3D


@onready var _particle_emmitter: int = ParticleSystem.instantiate_emitter(ParticleID.WALK_DUST, global_transform.origin)
@onready var _height: float = _get_collision_height()


func _ready() -> void:
	sleeping_state_changed.connect(_on_sleeping_state_changed)


func _exit_tree() -> void:
	ParticleSystem.remove_emitter(_particle_emmitter)


func _on_sleeping_state_changed() -> void:
	if not sleeping:
		_animate_movement()
	else:
		ParticleSystem.stop_emitter(_particle_emmitter)


func _animate_movement() -> void:
	while not sleeping:
		ParticleSystem.start_emitter(
				_particle_emmitter,
				global_transform.origin - Vector3(0.0, (_height/2.0)-0.1, 0.0))
		await get_tree().process_frame


func _get_collision_height() -> float:
	var collision_shape: CollisionShape3D = $CollisionShape3D
	
	if collision_shape.shape is BoxShape3D:
		return collision_shape.shape.size.y * scale.y
	elif collision_shape.shape is CapsuleShape3D or collision_shape.shape is CylinderShape3D:
		return collision_shape.shape.height * scale.y
	elif collision_shape.shape is SphereShape3D:
		return collision_shape.shape.radius * 2 * scale.y
	else:
		push_warning("Unsupported collision shape for height calculation: %s" % collision_shape.shape)
		return 0.0

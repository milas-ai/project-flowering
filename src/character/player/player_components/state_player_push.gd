class_name StatePlayerPush
extends State


@onready var _ray_cast := body.get_node("CharacterModel/RayCast3D")


func enter() -> void:
	body.animation_player.play("Poke")
	_ray_cast.enabled = true
	_ray_cast.force_raycast_update()

	if _ray_cast.is_colliding():
		var hit_object: Object = _ray_cast.get_collider()
		if hit_object.collision_layer & LayerBitmask.PUSHABLE:
			var push_direction: Vector3 = _ray_cast.global_transform.basis.z.normalized()
			var hit_point: Vector3 = _ray_cast.get_collision_point()
			hit_object.apply_impulse(push_direction * BaseStat.PLAYER.PUSH_FORCE, hit_point)
	
	get_tree().create_timer(0.46).timeout.connect(
			func(): state_machine.transition_to("StatePlayerIdle")
	)


func update(delta: float) -> void:
	body.process_horizontal_movement(delta, Vector3.ZERO, BaseStat.PLAYER.SPEED)


func exit() -> void:
	_ray_cast.enabled = false

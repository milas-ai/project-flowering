class_name PlayerPush
extends Node


@export var _push_force: float = 10.0

const PUSHABLE_LAYER_BITMASK: int = 1 << (4 - 1)

@onready var _ray_cast: RayCast3D = $"../../CharacterModel/RayCast3D"

var is_pushing: bool = false


func _ready() -> void:
	_ray_cast.enabled = false


func _on_player_input_push_pressed() -> void:
	if not is_pushing:
		is_pushing = true
		_ray_cast.enabled = true
		_ray_cast.force_raycast_update()
		
		if _ray_cast.is_colliding():
			var hit_object: CollisionObject3D = _ray_cast.get_collider()
			if hit_object.collision_layer & PUSHABLE_LAYER_BITMASK:
				var push_direction: Vector3 = _ray_cast.global_transform.basis.z.normalized()
				var hit_point: Vector3 = _ray_cast.get_collision_point() - hit_object.global_position
				hit_object.apply_impulse(push_direction * _push_force, hit_point)

		get_tree().create_timer(0.46).timeout.connect(func(): is_pushing = false; _ray_cast.enabled = false)

extends Enemy
class_name RolyPoly


const SPEED: float = 5
const WORLD_LAYER_BITMASK: int = 1 << (2 - 1) # world layer is 2, so we shift 1 left by (2 - 1) = 1 to get the bitmask for layer 2
const PUSHABLE_LAYER_BITMASK: int = 1 << (4 - 1)


func attack_player() -> void:
	look_at(player.global_transform.origin, Vector3.UP)
	rotation.x = 0
	animation_player.stop()
	animation_player.clear_queue()
	animation_player.play("attack")
	get_tree().create_timer(0.72).timeout.connect(func(): horizontal_velocity = -global_transform.basis.z * SPEED)
	while true:
		await get_tree().physics_frame
		for i in get_slide_collision_count():
			var collider = get_slide_collision(i).get_collider()
			if collider and "collision_layer" in collider:
				if collider.collision_layer & ~WORLD_LAYER_BITMASK:
					for body in $ExplosionArea.get_overlapping_bodies():
						if body.collision_layer & PUSHABLE_LAYER_BITMASK:
							var push_direction = global_transform.origin.direction_to(body.global_transform.origin)
							push_direction.y = 0
							body.apply_impulse(push_direction * 10)
						elif body.has_method("take_damage"):
							body.take_damage(4)
					queue_free()

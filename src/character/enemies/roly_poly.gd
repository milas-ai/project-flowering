extends Enemy
class_name RolyPoly


const SPEED: float = 5
const WORLD_LAYER_BITMASK: int = 1 << (2 - 1) # world layer is 2, so we shift 1 left by (2 - 1) = 1 to get the bitmask for layer 2

@export var explosion_radius: float = 150.0


func _ready() -> void:
	super()
	$"ExplosionArea/CollisionShape3D".shape.radius = explosion_radius

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
					# Explosion
					queue_free()

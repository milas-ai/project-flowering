extends RigidBody3D


const DAMAGE: int = 1

var velocity: Vector3 = Vector3.RIGHT
var speed: float = 1.0


func _process(delta: float) -> void:
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		if collision.get_collider().has_method("take_damage"):
			collision.get_collider().take_damage(DAMAGE)
		queue_free()

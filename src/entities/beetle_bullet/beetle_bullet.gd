class_name BeetleBullet
extends RigidBody3D


const TIME_TO_LIVE: float = 4.0

var velocity := Vector3.RIGHT
var speed: float = 1.0


func _process(delta: float) -> void:
	var collision: KinematicCollision3D = move_and_collide(velocity * speed * delta)
	
	get_tree().create_timer(TIME_TO_LIVE).connect(
			"timeout", Callable(self, "queue_free")
	)

	if collision:
		if collision.get_collider().has_method("take_damage"):
			collision.get_collider().take_damage(BaseStat.ENEMY.BEETLE.DAMAGE)
		queue_free()

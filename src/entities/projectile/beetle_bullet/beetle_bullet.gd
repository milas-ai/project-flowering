class_name BeetleBullet
extends Projectile


func _on_collided(collision: KinematicCollision3D) -> void:
	if collision.get_collider().has_method("take_damage"):
		collision.get_collider().take_damage(BaseStat.ENEMY.BEETLE.DAMAGE)
	queue_free()

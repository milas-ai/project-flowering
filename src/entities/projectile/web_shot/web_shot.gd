class_name WebShot
extends Projectile


signal collided()


func _on_collided(collision: KinematicCollision3D) -> void:
	if collision.get_collider().has_method("take_damage"):
		collision.get_collider().take_damage(BaseStat.BOSS.DAMAGE)
	collided.emit()
	queue_free()

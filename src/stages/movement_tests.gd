extends Node3D

func _on_bettle_shoot(Bullet, direction, location, speed) -> void:
	var spawned_bullet = Bullet.instantiate()
	add_child(spawned_bullet)
	spawned_bullet.rotation = direction
	spawned_bullet.position = location
	spawned_bullet.velocity = -spawned_bullet.global_transform.basis.z
	spawned_bullet.speed = speed

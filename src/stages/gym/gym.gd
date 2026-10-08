extends Node3D


@onready var _player_spawn_point: Marker3D = $PlayerSpawnPoint


func get_player_spawn_point() -> Vector3:
	if _player_spawn_point:
		return _player_spawn_point.global_position
	else:
		push_error("Player spawn point not found in the level.")
		return Vector3.ZERO


func _on_bettle_shoot(Bullet: PackedScene, direction: Vector3, location: Vector3, speed: float) -> void:
	var spawned_bullet: RigidBody3D = Bullet.instantiate()
	add_child(spawned_bullet)
	spawned_bullet.rotation = direction
	spawned_bullet.position = location
	spawned_bullet.velocity = -spawned_bullet.global_transform.basis.z
	spawned_bullet.speed = speed

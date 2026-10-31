class_name EntityRoot
extends Node3D


@onready var _bettle_bullet_scene: PackedScene = preload(SceneUID.ENTITIES.BETTLE_BULLET)
@onready var _roly_poly_scene: PackedScene = preload(SceneUID.ENEMIES.ROLY_POLY)
@onready var _bettle_scene: PackedScene = preload(SceneUID.ENEMIES.BETTLE)
@onready var _ant_scene: PackedScene = preload(SceneUID.ENEMIES.ANT)


func spawn_enemies(spawn_points: Array) -> void:
	for spawn_point in spawn_points:
		var enemy: Enemy
		if spawn_point is BeetleSpawnPoint:
			enemy = _bettle_scene.instantiate() as Enemy
			enemy.shoot.connect(_on_bettle_shoot)
		elif spawn_point is RolyPolySpawnPoint:
			enemy = _roly_poly_scene.instantiate() as Enemy
		elif spawn_point is AntSpawnPoint:
			enemy = _ant_scene.instantiate() as Enemy
		else:
			push_error("Unknown spawn point type: %s" % spawn_point)
			continue
		spawn_point.setup_enemy(enemy)
		add_child(enemy)


func _on_bettle_shoot(direction: Vector3, location: Vector3, speed: float) -> void:
	var spawned_bullet: BettleBullet = _bettle_bullet_scene.instantiate()
	add_child(spawned_bullet)
	spawned_bullet.rotation = direction
	spawned_bullet.position = location
	spawned_bullet.velocity = -spawned_bullet.global_transform.basis.z
	spawned_bullet.speed = speed

class_name EntityRoot
extends Node3D


@onready var _roly_poly_scene: PackedScene = preload(SceneUID.ENEMIES.ROLY_POLY)
@onready var _bettle_scene: PackedScene = preload(SceneUID.ENEMIES.BETTLE)
@onready var _ant_scene: PackedScene = preload(SceneUID.ENEMIES.ANT)


func spawn_enemies(spawn_points: Array) -> void:
	for spawn_point in spawn_points:
		var enemy: Enemy
		if spawn_point is BettleSpawnPoint:
			enemy = _bettle_scene.instantiate() as Enemy
		elif spawn_point is RolyPolySpawnPoint:
			enemy = _roly_poly_scene.instantiate() as Enemy
		elif spawn_point is AntSpawnPoint:
			enemy = _ant_scene.instantiate() as Enemy
		else:
			push_error("Unknown spawn point type: %s" % spawn_point)
			continue
		spawn_point.setup_enemy(enemy)
		add_child(enemy)

class_name BaseStage
extends Node3D


@export var has_life_hud: bool = true

@onready var enemy_spawn_points := get_tree().get_nodes_in_group("enemy_spawn_points")
@onready var _player_spawn_point: Marker3D = $PlayerSpawnPoint


func get_player_spawn_point() -> Vector3:
	if _player_spawn_point:
		return _player_spawn_point.global_position
	else:
		push_error("Player spawn point not found in the stage.")
		return Vector3.ZERO

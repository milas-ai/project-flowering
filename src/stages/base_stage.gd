class_name BaseStage
extends Node3D


@export var has_life_hud: bool = true

@export_group("Debug")
@export var spawn_on_checkpoint: bool = false

@onready var enemy_spawn_points := get_tree().get_nodes_in_group("enemy_spawn_points")
@onready var current_checkpoint: Marker3D
@onready var _player_spawn_point: Marker3D
@onready var _main_game: MainGame


func _ready() -> void:
	_main_game = $/root/MainGame
	_player_spawn_point = $PlayerSpawnPoint
	current_checkpoint = _player_spawn_point


func get_player_spawn_point() -> Vector3:
	if spawn_on_checkpoint:
		return $CheckPoints.get_child(0)._checkpoint_marker.global_position

	if _player_spawn_point:
		return _player_spawn_point.global_position
	else:
		push_error("Player spawn point not found in the stage.")
		return Vector3.ZERO

class_name BaseStage
extends Node3D


@export var has_life_hud: bool = true
@export_enum(
		"None",
		"Bottle Cap",
		"Scissors",
		"Firefly"
) var player_items_on_spawn: int = 0
@export_range(1, 160) var turntable_camera_size: int = 160

@export_group("Debug")
@export var spawn_on_checkpoint: bool = false

@onready var enemy_spawn_points := get_tree().get_nodes_in_group("enemy_spawn_points")
@onready var npc_spawn_points := get_tree().get_nodes_in_group("npc_spawn_points")
@onready var current_checkpoint: Marker3D
@onready var _player_spawn_point: Marker3D
@onready var _camera_position_marker: Marker3D
@onready var _main_game: MainGame


func _ready() -> void:
	_main_game = $/root/MainGame
	_player_spawn_point = $Markers/PlayerSpawnPoint
	_camera_position_marker = $Markers/CameraPosition
	current_checkpoint = _player_spawn_point


func get_player_spawn_point() -> Vector3:
	if spawn_on_checkpoint:
		return $CheckPoints.get_child(0)._checkpoint_marker.global_position

	if _player_spawn_point:
		return _player_spawn_point.global_position
	else:
		push_error("Player spawn point not found in the stage.")
		return Vector3.ZERO


func get_camera_position() -> Vector3:
	if _camera_position_marker:
		return _camera_position_marker.global_position
	else:
		push_error("Camera position marker not found in the stage.")
		return Vector3.ZERO


func _on_respawn_area_body_entered(body: Node3D) -> void:
	if body.collision_layer & LayerBitmask.PLAYER:
		if has_life_hud:
			_main_game.player.take_damage(1)
		_main_game.player.horizontal_velocity = Vector3.ZERO
		_main_game.player.vertical_velocity = Vector3.ZERO
		_main_game.player.global_position = current_checkpoint.global_position
		_main_game.player.state_machine.reset_pressed_inputs()

	elif body.collision_layer & LayerBitmask.ENEMY:
		body.queue_free()


func _on_npc_dialog_finished(_npc_name: String) -> void:
	pass

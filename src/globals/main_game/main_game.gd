class_name MainGame
extends Node


const PLAYER_SCENE_UID = "uid://cn4xgyysgu8vt"

@onready var level_root: Node3D = %LevelRoot
@onready var entity_root: Node3D = %EntityRoot
@onready var hud_root: Control = %HudRoot
@onready var pause_root: Control = %PauseRoot

var player: Player = null
var _current_level: Node3D = null


func _ready() -> void:
	_init_player()
	load_level("uid://dayem3vrpenok")


func _init_player() -> void:
	var player_scene: PackedScene = ResourceLoader.load(PLAYER_SCENE_UID)
	if not player_scene:
		push_error("Failed to load player scene.")
		return

	player = player_scene.instantiate() as Player
	if not player:
		push_error("Failed to instantiate player scene.")
		return

	entity_root.add_child(player)


func _place_player_at_spawn_point() -> void:
	if not player or not _current_level:
		push_error("Player or current level is not initialized.")
		return

	player.global_position = _current_level.get_player_spawn_point()


func load_level(level_scene_uid: String) -> void:
	if _current_level:
		_current_level.queue_free()
		_current_level = null

	# Wait for the last level to be freed before loading the new one
	await get_tree().process_frame

	var level_scene: PackedScene = ResourceLoader.load(level_scene_uid)
	if not level_scene:
		push_error("Failed to load level scene: %s" % level_scene_uid)
		return

	_current_level = level_scene.instantiate() as Node3D
	if not _current_level:
		push_error("Failed to instantiate level scene: %s" % level_scene_uid)
		return

	level_root.add_child(_current_level)

	# Wait for the new level to be added to the scene tree before adding the player
	await get_tree().process_frame
	_place_player_at_spawn_point()

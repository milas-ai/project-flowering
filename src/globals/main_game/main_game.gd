class_name MainGame
extends Node


var player: Player = null
var _current_stage: Node3D = null

@onready var stage_root: Node3D = %StageRoot
@onready var entity_root: Node3D = %EntityRoot
@onready var hud_root: Control = %HudRoot
@onready var pause_root: Control = %PauseRoot


func _ready() -> void:
	_init_player()
	load_stage(SceneUID.STAGE_GYM)


func load_stage(stage_scene_uid: String) -> void:
	if _current_stage:
		_current_stage.queue_free()
		_current_stage = null

	# Wait for the last stage to be freed before loading the new one
	await get_tree().process_frame

	var stage_scene: PackedScene = ResourceLoader.load(stage_scene_uid)
	if not stage_scene:
		push_error("Failed to load stage scene: %s" % stage_scene_uid)
		return

	_current_stage = stage_scene.instantiate() as Node3D
	if not _current_stage:
		push_error("Failed to instantiate stage scene: %s" % stage_scene_uid)
		return

	stage_root.add_child(_current_stage)

	# Wait for the new stage to be added to the scene tree before adding the player
	await get_tree().process_frame
	_place_player_at_spawn_point()


func _init_player() -> void:
	var player_scene: PackedScene = ResourceLoader.load(SceneUID.PLAYER)
	if not player_scene:
		push_error("Failed to load player scene.")
		return

	player = player_scene.instantiate() as Player
	if not player:
		push_error("Failed to instantiate player scene.")
		return

	entity_root.add_child(player)


func _place_player_at_spawn_point() -> void:
	if not player or not _current_stage:
		push_error("Player or current stage is not initialized.")
		return

	player.global_position = _current_stage.get_player_spawn_point()

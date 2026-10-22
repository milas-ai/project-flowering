class_name MainGame
extends Node


var player: Player = null
var options: Options = null
var _current_stage: Node3D = null

@onready var stage_root: Node3D = %StageRoot
@onready var entity_root: Node3D = %EntityRoot
@onready var hud_root: HudRoot = %HudRoot
@onready var pause_root: Control = %PauseRoot


func _ready() -> void:
	var save_data: SaveManager.SaveData = SaveManager.load()
	if save_data:
		options = save_data.options
	else:
		options = Options.new()
		
	_init_player()
	load_stage(SceneUID.STAGES.GYM)
	pause_root.init_options_menu()
	hud_root.load_main_stage_hud()


func _input(event: InputEvent) -> void:
	if get_tree().paused:
		return
		
	if event is InputEventKey:
		if event.is_action_pressed("pause"):
			get_viewport().set_input_as_handled()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().paused = true
			pause_root.show_options_menu()
			
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		return


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

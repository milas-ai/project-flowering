class_name MainGame
extends Node


@export_group("Debug")
@export_enum(
		"Gym:-1", 
		"Menu",
		"Mountain",
) var debug_stage: int = 0

var player: Player = null
var options: Options
var _current_stage: BaseStage = null
var _current_stage_uid: String

@onready var stage_root: Node3D = %StageRoot
@onready var entity_root: EntityRoot = %EntityRoot
@onready var hud_root: HudRoot = %HudRoot
@onready var pause_root: Control = %PauseRoot
@onready var _game_container: SubViewportContainer = %GameViewport


func _ready() -> void:
	_load_save_data()
	if debug_stage:
		_current_stage_uid = stage_id_to_uid(debug_stage)
	_init_player()
	reset_stage()


func _input(event: InputEvent) -> void:
	if get_tree().paused:
		return
		
	if event.is_action_pressed("pause"):
		get_viewport().set_input_as_handled()
		pause_root.pause_game(event is InputEventJoypadButton)
			
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		return


func transition_to_stage(stage_scene_uid: String) -> void:
	_load_stage(stage_scene_uid)
	pause_root.init_options_menu()

	await get_tree().process_frame

	entity_root.spawn_enemies(_current_stage.enemy_spawn_points)

	if _current_stage.has_life_hud:
		hud_root.load_main_stage_hud()


func reset_stage() -> void:
	transition_to_stage(_current_stage_uid)


func stage_id_to_uid(stage_id: int) -> String:
	match stage_id:
		-1:
			return SceneUID.STAGES.GYM
		1:
			return SceneUID.STAGES.MOUNTAIN
		_:
			push_error("Invalid stage ID: %d" % stage_id)
			return ""


func set_player_items(items: int) -> void:
	player.items = items


func _load_stage(stage_scene_uid: String) -> void:
	if _current_stage:
		_current_stage.queue_free()
		_current_stage = null
		for child in entity_root.get_children():
			if not child is Player:
				child.queue_free()

	# Wait for the last stage to be freed before loading the new one
	await get_tree().process_frame

	var stage_scene: PackedScene = ResourceLoader.load(stage_scene_uid)
	if not stage_scene:
		push_error("Failed to load stage scene: %s" % stage_scene_uid)
		return

	_current_stage = stage_scene.instantiate() as BaseStage
	if not _current_stage:
		push_error("Failed to instantiate stage scene: %s" % stage_scene_uid)
		return

	stage_root.add_child(_current_stage)

	# Wait for the new stage to be added to the scene tree before adding the player
	await get_tree().process_frame
	player.health = BaseStat.PLAYER.HEALTH
	_place_player_at_spawn_point()

	_current_stage_uid = stage_scene_uid
	_save_game()


func _change_volume(volume_type: String, delta: int) -> void:
	if not options.volume.has(volume_type):
		push_error("Invalid volume type: %s" % volume_type)
		return

	options.volume[volume_type] = clamp(options.volume[volume_type] + delta, 0, 100)
	options.volume_change.emit(options.volume)

	AudioServer.set_bus_volume_linear(
		AudioServer.get_bus_index(volume_type.capitalize()),
		options.volume[volume_type] / 100.0
	)


func _set_aspect_ratio(retro_aspect_ratio: bool) -> void:
	options.retro_aspect_ratio = retro_aspect_ratio
	if options.retro_aspect_ratio:
		get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP
	else:
		get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP_HEIGHT


func _set_fullscreen(fullscreen: bool) -> void:
	options.fullscreen = fullscreen
	if options.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _set_language(index: int) -> void:
	options.language = Options.language_index_to_string(index)
	TranslationServer.set_locale(options.language)


func _change_pixelization_level(delta: int) -> void:
	options.pixelization_level = clamp(1, options.pixelization_level + delta, 11)
	_game_container.stretch_shrink = options.pixelization_level


func _set_camera_sensitivity(camera_sensitivity: int) -> void:
	options.camera_sensitivity = max(1, camera_sensitivity)


func _save_game() -> void:
	var save_data : SaveManager.SaveData = SaveManager.SaveData.new()
	save_data.options = options
	save_data.stage_uid = _current_stage_uid
	SaveManager.save(save_data)


func _exit_game() -> void:
	_save_game()
	get_tree().quit()


func _init_player() -> void:
	var player_scene: PackedScene = ResourceLoader.load(SceneUID.PLAYER)
	if not player_scene:
		push_error("Failed to load player scene.")
		return

	player = player_scene.instantiate() as Player
	if not player:
		push_error("Failed to instantiate player scene.")
		return

	player.dead.connect(reset_stage)
	entity_root.add_child(player)


func _place_player_at_spawn_point() -> void:
	if not player or not _current_stage:
		push_error("Player or current stage is not initialized.")
		return

	player.global_position = _current_stage.get_player_spawn_point()


func _load_save_data() -> void:
	var save_data: SaveManager.SaveData = SaveManager.load()
	if save_data:
		options = save_data.options
		_current_stage_uid = save_data.stage_uid
	else:
		options = Options.new()
		_current_stage_uid = SceneUID.STAGES.GYM
	_change_volume("master", 0)
	_change_volume("music", 0)
	_change_volume("sfx", 0)
	_set_aspect_ratio(options.retro_aspect_ratio)
	_set_fullscreen(options.fullscreen)
	_set_language(Options.language_string_to_index(options.language))
	_change_pixelization_level(0)

class_name HudRoot
extends Control


var _main_menu: Control
var _options_menu: Control

@onready var _main_game: MainGame = $/root/MainGame
@onready var _dialog_box: DialogBox = $DialogBox
@onready var _vignette: ColorRect = $Vignette


func load_main_stage_hud() -> void:
	if get_node_or_null("HealthContainer"):
		return

	var health_container_scene: PackedScene = ResourceLoader.load(SceneUID.GUI.HEALTH_CONTAINER)
	var health_container: HBoxContainer = health_container_scene.instantiate()
	add_child(health_container)
	_main_game.player.update_health.connect(health_container._on_player_update_health)


func display_dialog(dialog_text: String) -> void:
	get_tree().paused = true
	_dialog_box.process_mode = PROCESS_MODE_INHERIT
	_dialog_box.display_dialog(_trim_dialog_text(dialog_text))


func animate_vignette(target_radius: float, duration: float) -> void:
	_vignette.visible = true
	var window_size: Vector2 = get_viewport().get_visible_rect().size
	_vignette.material.set_shader_parameter("screen_width", window_size.x)
	_vignette.material.set_shader_parameter("screen_height", window_size.y)
	_vignette.material.set_shader_parameter("vignette_softness", 0.035)
	
	var tween: Tween = create_tween()
	tween.tween_property(_vignette.material, "shader_parameter/vignette_radius", target_radius, duration)
	await tween.finished
	if target_radius == 0.0:
		_vignette.material.set_shader_parameter("vignette_softness", 0.0)
	if target_radius >= (window_size.x / window_size.y) / (4.0/3.0):
		_vignette.visible = false


func init_main_menu() -> void:
	var main_menu_scene: PackedScene = ResourceLoader.load(SceneUID.GUI.MAIN_MENU)
	if not main_menu_scene:
		push_error("Failed to load main menu scene.")
		return
	
	_main_menu = main_menu_scene.instantiate() as Control
	if not _main_menu:
		push_error("Failed to instantiate main menu scene.")
		return

	add_child(_main_menu)

	var options_menu_scene: PackedScene = ResourceLoader.load(SceneUID.GUI.OPTIONS_MENU)
	if not options_menu_scene:
		push_error("Failed to load options menu scene.")
		return
	
	_options_menu = options_menu_scene.instantiate() as Control
	if not _options_menu:
		push_error("Failed to instantiate options menu scene.")
		return

	_options_menu.hide()
	add_child(_options_menu)
	_options_menu.exit_game_button.hide()


func _on_dialog_box_dialog_finished() -> void:
	_dialog_box.process_mode = PROCESS_MODE_DISABLED
	get_tree().paused = false


func _trim_dialog_text(dialog_text: String) -> String:
	var lines: Array = dialog_text.split("\n")
	for i in range(lines.size()):
		lines[i] = _trim_line_to_max_characters(lines[i])
	return "\n".join(lines)


func _trim_line_to_max_characters(line: String) -> String:
		var tag_size: int = _find_tag_part_size(line)
		if line.length() <= DialogBox.MAX_CHARACTERS_PER_LINE + tag_size:
			return line
		else:
			var first_line_part: String
			if tag_size > 0:
				first_line_part = line.substr(0, DialogBox.MAX_CHARACTERS_PER_LINE + tag_size)
			else:
				first_line_part = line.substr(0, DialogBox.MAX_CHARACTERS_PER_LINE)
			var last_space_index: int = first_line_part.rfind(" ")
			first_line_part = first_line_part.substr(0, last_space_index) + "..."
			var remaining_text: String = line.substr(last_space_index + 1, line.length() - last_space_index - 1)
			return first_line_part + "\n" + _trim_line_to_max_characters(remaining_text)


func _find_tag_part_size(line: String, base_size: int = 0) -> int:
	var tag_start_open_index: int = line.find("[")
	if tag_start_open_index == -1:
		return 0
	
	var tag_start_close_index: int = line.find("]")
	if tag_start_close_index == -1 or tag_start_close_index < tag_start_open_index:
		push_error("Invalid tag format in line: %s" % line)
		return 0
	
	var tag_end_close_index: int = line.substr(tag_start_close_index + 1).find("]")
	if tag_end_close_index == -1:
		push_error("Invalid tag format in line: %s" % line)
		return 0
	tag_end_close_index += tag_start_close_index + 1

	var tag_part_size: int = tag_end_close_index - tag_start_open_index
	var remaining_text: String = line.substr(tag_end_close_index + 1, line.length() - tag_end_close_index - 1)
	return tag_part_size + _find_tag_part_size(remaining_text, base_size + tag_part_size)


func _show_main_menu() -> void:
	_options_menu.hide()
	_main_menu.show()


func _show_options_menu() -> void:
	_main_menu.hide()
	_options_menu.show()


func _on_options_save_settings_pressed() -> void:
	_main_game._save_game()
	_show_main_menu()

class_name HudRoot
extends Control


@onready var _main_game: MainGame = $/root/MainGame
@onready var _dialog_box: DialogBox = $DialogBox


func load_main_stage_hud() -> void:
	var health_container_scene: PackedScene = ResourceLoader.load(SceneUID.GUI.HEALTH_CONTAINER)
	var health_container: HBoxContainer = health_container_scene.instantiate()
	add_child(health_container)
	_main_game.player.update_health.connect(health_container._on_player_update_health)


func display_dialog(dialog_text: String) -> void:
	get_tree().paused = true
	_dialog_box.process_mode = PROCESS_MODE_INHERIT
	_dialog_box.display_dialog(_trim_dialog_text(dialog_text))


func _on_dialog_box_dialog_finished() -> void:
	_dialog_box.process_mode = PROCESS_MODE_DISABLED
	get_tree().paused = false


func _trim_dialog_text(dialog_text: String) -> String:
	var lines: Array = dialog_text.split("\n")
	for i in range(lines.size()):
		lines[i] = _trim_line_to_max_characters(lines[i])
	return "\n".join(lines)


func _trim_line_to_max_characters(line: String) -> String:
		if line.length() <= DialogBox.MAX_CHARACTERS_PER_LINE:
			return line
		else:
			var first_line_part: String = line.substr(0, DialogBox.MAX_CHARACTERS_PER_LINE)
			var last_space_index: int = first_line_part.rfind(" ")
			first_line_part = first_line_part.substr(0, last_space_index) + "..."
			var remaining_text: String = line.substr(last_space_index + 1, line.length() - last_space_index - 1)
			return first_line_part + "\n" + _trim_line_to_max_characters(remaining_text)

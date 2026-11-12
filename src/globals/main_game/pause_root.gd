class_name PauseRoot
extends Control


var _options_menu: Control

@onready var _main_game: MainGame = $/root/MainGame


func _unhandled_input(event: InputEvent) -> void:
	if ControllerManager.input_lock:
		return

	if event.is_action_pressed("pause"):
		if visible:
			get_viewport().set_input_as_handled()
			hide_pause_menu()
			get_tree().paused = false


func init_options_menu() -> void:
	var options_menu_scene: PackedScene = ResourceLoader.load(SceneUID.GUI.OPTIONS_MENU)
	if not options_menu_scene:
		push_error("Failed to load options menu scene.")
		return
	
	_options_menu = options_menu_scene.instantiate() as Control
	if not _options_menu:
		push_error("Failed to instantiate options menu scene.")
		return
	
	add_child(_options_menu)


func show_pause_menu() -> void:
	show()


func hide_pause_menu() -> void:
	hide()
	ControllerManager.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_options_save_settings_pressed() -> void:
	_main_game._save_game()
	hide_pause_menu()
	get_tree().paused = false

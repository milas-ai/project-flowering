class_name PauseRoot
extends Control


var _options_menu: Control


func _unhandled_input(event: InputEvent) -> void:
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


func show_pause_menu(with_controller: bool = false) -> void:
	ControllerManager.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if with_controller:
		_options_menu.focus_first_control()
	show()


func hide_pause_menu() -> void:
	ControllerManager.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hide()
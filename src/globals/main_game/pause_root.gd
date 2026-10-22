class_name PauseRoot
extends Control


var _options_menu: Control


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("pause"):
			get_viewport().set_input_as_handled()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			hide_options_menu()
			get_tree().paused = false


func show_options_menu() -> void:
	_options_menu.show()


func hide_options_menu() -> void:
	_options_menu.hide()


func init_options_menu() -> void:
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

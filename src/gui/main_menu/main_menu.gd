extends Control


@onready var _version_label = %VersionLabel
@onready var _options_button = %OptionsButton


func _ready():
	_version_label.text = "Version: " + ProjectSettings.get_setting("application/config/version")
	_connect_ui_signals()
	ControllerManager.controller_layout_changed.connect(_on_controller_layout_changed)
	_on_controller_layout_changed()


func _connect_ui_signals() -> void:
	%NewGameButton.pressed.connect(_on_new_game_pressed)
	%LoadGameButton.pressed.connect(_on_load_game_pressed)
	_options_button.pressed.connect(_on_options_pressed)
	%ExitGameButton.pressed.connect(_on_exit_game_pressed)


func _on_controller_layout_changed() -> void:
	if ControllerManager.controller_layout.type != ControllerManager.TYPE.KEYBOARD:
		_options_button.grab_focus()
		ControllerManager.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		get_viewport().gui_get_focus_owner().release_focus()
		ControllerManager.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		


func _on_new_game_pressed() -> void:
	print("New Game button pressed")


func _on_load_game_pressed() -> void:
	print("Load Game button pressed")


func _on_options_pressed() -> void:
	print("Options button pressed")


func _on_exit_game_pressed() -> void:
	get_tree().quit()

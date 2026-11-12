extends BaseMenu


@onready var _version_label = %VersionLabel
@onready var _new_game_button = %NewGameButton


func _ready():
	super._ready()
	_version_label.text = "Version: " + ProjectSettings.get_setting("application/config/version")
	_connect_ui_signals()
	_on_controller_layout_changed()


func focus_first_control() -> void:
	_new_game_button.grab_focus.call_deferred()


func _connect_ui_signals() -> void:
	_new_game_button.pressed.connect(_on_new_game_pressed)
	%LoadGameButton.pressed.connect(_on_load_game_pressed)
	%OptionsButton.pressed.connect(_parent_control._show_options_menu)
	%ExitGameButton.pressed.connect(_on_exit_game_pressed)


func _on_new_game_pressed() -> void:
	print("New Game button pressed")


func _on_load_game_pressed() -> void:
	print("Load Game button pressed")


func _on_exit_game_pressed() -> void:
	get_tree().quit()

extends BaseMenu


@onready var _version_label = %VersionLabel
@onready var _options_button = %OptionsButton


func _ready():
	super._ready()
	_version_label.text = "Version: " + ProjectSettings.get_setting("application/config/version")
	_connect_ui_signals()


func focus_first_control() -> void:
	_options_button.grab_focus.call_deferred()


func _connect_ui_signals() -> void:
	%NewGameButton.pressed.connect(_on_new_game_pressed)
	%LoadGameButton.pressed.connect(_on_load_game_pressed)
	_options_button.pressed.connect(_on_options_pressed)
	%ExitGameButton.pressed.connect(_on_exit_game_pressed)


func _on_new_game_pressed() -> void:
	print("New Game button pressed")


func _on_load_game_pressed() -> void:
	print("Load Game button pressed")


func _on_options_pressed() -> void:
	print("Options button pressed")


func _on_exit_game_pressed() -> void:
	get_tree().quit()

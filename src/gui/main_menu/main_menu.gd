extends Control


@onready var VersionLabel = %VersionLabel


func _ready():
	VersionLabel.text = "Version: " + ProjectSettings.get_setting("application/config/version")
	_connect_ui_signals()


func _connect_ui_signals() -> void:
	%NewGameButton.pressed.connect(_on_new_game_pressed)
	%LoadGameButton.pressed.connect(_on_load_game_pressed)
	%OptionsButton.pressed.connect(_on_options_pressed)
	%ExitGameButton.pressed.connect(_on_exit_game_pressed)


func _on_new_game_pressed() -> void:
	print("New Game button pressed")


func _on_load_game_pressed() -> void:
	print("Load Game button pressed")


func _on_options_pressed() -> void:
	print("Options button pressed")


func _on_exit_game_pressed() -> void:
	get_tree().quit()

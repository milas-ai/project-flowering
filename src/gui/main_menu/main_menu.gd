extends BaseMenu


var _first_control: Control

@onready var _new_game_button = %NewGameButton
@onready var _banner_margin_container = $BannerMarginContainer
@onready var _version_margin_container = $VersionMarginContainer
@onready var _buttons_margin_container = $ButtonsMarginContainer
@onready var _confirmation_prompt = $ConfirmationPrompt
@onready var _cancel_button = %CancelButton


func _ready():
	super._ready()
	_first_control = _new_game_button
	%VersionLabel.text = "Version: " + ProjectSettings.get_setting("application/config/version")
	_connect_ui_signals()
	_on_controller_layout_changed()


func focus_first_control() -> void:
	_first_control.grab_focus.call_deferred()


func _connect_ui_signals() -> void:
	_new_game_button.pressed.connect(_on_new_game_pressed)
	%LoadGameButton.pressed.connect(_on_load_game_pressed)
	%OptionsButton.pressed.connect(_parent_control._show_options_menu)
	%ExitGameButton.pressed.connect(_on_exit_game_pressed)
	%AcceptButton.pressed.connect(_on_accept_button_pressed)
	_cancel_button.pressed.connect(_on_cancel_button_pressed)


func _on_new_game_pressed() -> void:
	_show_confirmation_prompt()


func _on_load_game_pressed() -> void:
	print("Load Game button pressed")


func _on_exit_game_pressed() -> void:
	get_tree().quit()


func _on_accept_button_pressed() -> void:
	print("Accept button pressed")


func _on_cancel_button_pressed() -> void:
	_confirmation_prompt.hide()
	_buttons_margin_container.show()
	_banner_margin_container.show()
	_version_margin_container.show()
	_first_control = _new_game_button
	_on_controller_layout_changed()


func _show_confirmation_prompt() -> void:
	_buttons_margin_container.hide()
	_banner_margin_container.hide()
	_version_margin_container.hide()
	_confirmation_prompt.show()
	_first_control = _cancel_button
	_on_controller_layout_changed()

extends BaseMenu


var _first_control: Control

@onready var _new_game_button: Button = %NewGameButton
@onready var _banner_margin_container: MarginContainer = $BannerMarginContainer
@onready var _version_margin_container: MarginContainer = $VersionMarginContainer
@onready var _buttons_margin_container: MarginContainer = $ButtonsMarginContainer
@onready var _confirmation_prompt: Control = $ConfirmationPrompt
@onready var _cancel_button: Button = %CancelButton
@onready var _banner_texture_green: Texture2D = load(AssetUID.TEXTURE.BANNER.GREEN)
@onready var _banner_texture_yellow: Texture2D = load(AssetUID.TEXTURE.BANNER.YELLOW)
@onready var _banner_texture_pink: Texture2D = load(AssetUID.TEXTURE.BANNER.PINK)


func _ready():
	super._ready()
	_connect_ui_signals()
	_update_version_label_text()
	_update_banner_texture()
	_on_controller_layout_changed()
	_first_control = _new_game_button


func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		_update_version_label_text()


func focus_first_control() -> void:
	_first_control.grab_focus.call_deferred()


func _update_version_label_text() -> void:
	%VersionLabel.text = tr("VERSION_LABEL").format({
			"version" : ProjectSettings.get_setting("application/config/version")})


func _connect_ui_signals() -> void:
	_new_game_button.pressed.connect(_on_new_game_pressed)
	%LoadGameButton.pressed.connect(_parent_control._on_main_menu_load_game_pressed)
	%OptionsButton.pressed.connect(_parent_control._show_options_menu)
	%ExitGameButton.pressed.connect(_on_exit_game_pressed)
	%AcceptButton.pressed.connect(_parent_control._on_main_menu_load_game_pressed.bind(true))
	_cancel_button.pressed.connect(_on_cancel_button_pressed)


func _on_new_game_pressed() -> void:
	_show_confirmation_prompt()


func _on_exit_game_pressed() -> void:
	get_tree().quit()


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


func _update_banner_texture() -> void:
	var display_stage: String = _main_game.get_last_stage_uid()
	match display_stage:
		SceneUID.STAGES.GYM:
			%Banner.texture = _banner_texture_green
		SceneUID.STAGES.MOUNTAIN:
			%Banner.texture = _banner_texture_yellow
		SceneUID.STAGES.CAVE:
			%Banner.texture = _banner_texture_pink
		_:
			push_error("Invalid stage UID: %s" % display_stage)

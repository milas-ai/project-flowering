extends BaseMenu


@onready var _aspect_ratio_check_box: CheckBox = %AspectRatioCheckBox
@onready var _fullscreen_check_box: CheckBox = %FullscreenCheckBox
@onready var _language_drop_button: OptionButton = %LanguageDropButton
@onready var _camera_sensitivity_slider: HSlider = %CameraSensitivitySlider
@onready var _volume_master_bar: TextureRect = %VolumeMasterBar
@onready var _volume_music_bar: TextureRect = %VolumeMusicBar
@onready var _volume_sfx_bar: TextureRect = %VolumeSFXBar
@onready var _pixelization_level_bar: TextureRect = %PixelizationLevelBar
@onready var _exit_game_button: Button = %ExitGameButton


func _ready() -> void:
	super._ready()
	_connect_options_change_signals()
	_connect_ui_signals()

	for language in Options.LANGUAGE_OPTIONS:
		_language_drop_button.add_item(language)
	
	_aspect_ratio_check_box.button_pressed = _main_game.options.retro_aspect_ratio
	_fullscreen_check_box.button_pressed = _main_game.options.fullscreen
	_language_drop_button.selected = Options.language_string_to_index(_main_game.options.language)
	_camera_sensitivity_slider.value = _main_game.options.camera_sensitivity
	_on_volume_change(_main_game.options.volume)
	_on_pixelization_level_change(_main_game.options.pixelization_level)

	if _parent_control is PauseRoot:
		_exit_game_button.text = "EXIT_GAME_LABEL"
	else:
		_exit_game_button.text = "BACK_TO_MAIN_MENU_LABEL"


func focus_first_control() -> void:
	_language_drop_button.grab_focus.call_deferred()


func _connect_options_change_signals() -> void:
	_main_game.options.volume_change.connect(_on_volume_change)
	_main_game.options.language_change.connect(_on_language_change)
	_main_game.options.pixelization_level_change.connect(_on_pixelization_level_change)


func _connect_ui_signals() -> void:
	%VolumeMasterUpButton.pressed.connect(_main_game._change_volume.bind("master", +10))
	%VolumeMasterDownButton.pressed.connect(_main_game._change_volume.bind("master", -10))
	%VolumeMusicUpButton.pressed.connect(_main_game._change_volume.bind("music", +10))
	%VolumeMusicDownButton.pressed.connect(_main_game._change_volume.bind("music", -10))
	%VolumeSFXUpButton.pressed.connect(_main_game._change_volume.bind("sfx", +10))
	%VolumeSFXDownButton.pressed.connect(_main_game._change_volume.bind("sfx", -10))
	_fullscreen_check_box.toggled.connect(_main_game._set_fullscreen)
	_aspect_ratio_check_box.toggled.connect(_main_game._set_aspect_ratio)
	_language_drop_button.item_selected.connect(_main_game._set_language)
	%PixelizationUpButton.pressed.connect(_main_game._change_pixelization_level.bind(+1))
	%PixelizationDownButton.pressed.connect(_main_game._change_pixelization_level.bind(-1))
	_camera_sensitivity_slider.value_changed.connect(_main_game._set_camera_sensitivity)
	%SaveSettingsButton.pressed.connect(_parent_control._on_options_save_settings_pressed)
	_exit_game_button.pressed.connect(_parent_control._on_options_exit_game_pressed)


func _on_volume_change(volume: Dictionary[String, int]) -> void:
	_volume_master_bar.texture.region.position.y = 9 * volume["master"] / 10.0
	_volume_music_bar.texture.region.position.y = 9 * volume["music"] / 10.0
	_volume_sfx_bar.texture.region.position.y = 9 * volume["sfx"] / 10.0


func _on_language_change(language: StringName) -> void:
	_language_drop_button.selected = Options.language_string_to_index(language)


func _on_pixelization_level_change(pixelization_level: int) -> void:
	_pixelization_level_bar.texture.region.position.y = 9 * (pixelization_level-1)

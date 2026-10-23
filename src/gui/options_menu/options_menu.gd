extends Control


@onready var _main_game: MainGame = $/root/MainGame
@onready var _aspect_ratio_check_button: CheckButton = %AspectRatioCheckButton
@onready var _fullscreen_check_button: CheckButton = %FullscreenCheckButton
@onready var _language_drop_button: OptionButton = %LanguageDropButton
@onready var _mouse_sensitivity_slider: HSlider = %MouseSensitivitySlider


func _ready() -> void:
	_connect_options_change_signals()
	_connect_ui_signals()

	for language in Options.LANGUAGE_OPTIONS:
		_language_drop_button.add_item(language)
	
	_aspect_ratio_check_button.button_pressed = _main_game.options.retro_aspect_ratio
	_fullscreen_check_button.button_pressed = _main_game.options.fullscreen
	_language_drop_button.selected = Options.language_string_to_index(_main_game.options.language)
	_mouse_sensitivity_slider.value = _main_game.options.mouse_sensitivity


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
	_fullscreen_check_button.toggled.connect(_main_game._set_fullscreen)
	_aspect_ratio_check_button.toggled.connect(_main_game._set_aspect_ratio)
	_language_drop_button.item_selected.connect(_main_game._set_language)
	%PixelizationUpButton.pressed.connect(_main_game._change_pixelization_level.bind(+1))
	%PixelizationDownButton.pressed.connect(_main_game._change_pixelization_level.bind(-1))
	_mouse_sensitivity_slider.value_changed.connect(_main_game._set_mouse_sensitivity)
	%SaveSettingsButton.pressed.connect(_main_game._save_game)
	%ExitGameButton.pressed.connect(_main_game._exit_game)
	

func _on_volume_change(volume: Dictionary[String, int]) -> void:
	print("Volume changed to: %s" % volume)


func _on_language_change(language: StringName) -> void:
	_language_drop_button.selected = Options.language_string_to_index(language)


func _on_pixelization_level_change(pixelization_level: int) -> void:
	print("Pixelization level changed to: %s" % pixelization_level)

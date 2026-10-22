extends Control


@onready var _main_game: MainGame = $/root/MainGame
@onready var _aspect_ratio_drop_button: OptionButton = %AspectRatioDropButton
@onready var _fullscreen_check_button: CheckButton = %FullscreenCheckButton
@onready var _language_drop_button: OptionButton = %LanguageDropButton
@onready var _mouse_sensitivity_slider: HSlider = %MouseSensitivitySlider


func _ready() -> void:
	_connect_options_change_signals()
	_connect_ui_signals()

	for language in Options.LANGUAGE_OPTIONS:
		_language_drop_button.add_item(language)
	
	for aspect_ratio in Options.ASPECT_RATIO_OPTIONS:
		_aspect_ratio_drop_button.add_item("%dx%d" % [aspect_ratio.x, aspect_ratio.y])

	_fullscreen_check_button.button_pressed = _main_game.options.fullscreen
	_mouse_sensitivity_slider.value = _main_game.options.mouse_sensitivity


func _connect_options_change_signals() -> void:
	_main_game.options.volume_change.connect(_on_volume_change)
	_main_game.options.aspect_ratio_change.connect(_on_aspect_ratio_change)
	_main_game.options.fullscreen_change.connect(_on_fullscreen_change)
	_main_game.options.language_change.connect(_on_language_change)
	_main_game.options.pixelization_level_change.connect(_on_pixelization_level_change)


func _connect_ui_signals() -> void:
	%VolumeMasterUpButton.pressed.connect(_main_game.change_volume.bind("master", +10))
	%VolumeMasterDownButton.pressed.connect(_main_game.change_volume.bind("master", -10))
	_fullscreen_check_button.toggled.connect(_main_game.set_fullscreen)
	_aspect_ratio_drop_button.item_selected.connect(_main_game.set_aspect_ratio)
	_language_drop_button.item_selected.connect(_main_game.set_language)
	%PixelizationUpButton.pressed.connect(
			_main_game.set_pixelization_level.bind(_main_game.options.pixelization_level + 1))
	%PixelizationDownButton.pressed.connect(
			_main_game.set_pixelization_level.bind(_main_game.options.pixelization_level - 1))
	_mouse_sensitivity_slider.value_changed.connect(_main_game.set_mouse_sensitivity)
	%SaveSettingsButton.pressed.connect(_main_game.resume_game)
	%ExitGameButton.pressed.connect(_main_game.exit_game)
	

# Options Signal Handlers
func _on_volume_change(volume: Dictionary[String, int]) -> void:
	print("Volume changed to: %s" % volume)


func _on_aspect_ratio_change(aspect_ratio: Vector2) -> void:
	_aspect_ratio_drop_button.selected = Options.aspect_ratio_vector_to_index(aspect_ratio)


func _on_fullscreen_change(fullscreen: bool) -> void:
	_fullscreen_check_button.button_pressed = _main_game.options.fullscreen


func _on_language_change(language: StringName) -> void:
	_language_drop_button.selected = Options.language_string_to_index(language)


func _on_pixelization_level_change(pixelization_level: int) -> void:
	print("Pixelization level changed to: %s" % pixelization_level)

extends Control


@onready var _main_game: MainGame = $/root/MainGame


func _ready() -> void:
	_connect_options_change_signals()
	_connect_ui_signals()


func _connect_options_change_signals() -> void:
	_main_game.options.volume_change.connect(_on_volume_change)
	_main_game.options.aspect_ratio_change.connect(_on_aspect_ratio_change)
	_main_game.options.fullscreen_change.connect(_on_fullscreen_change)
	_main_game.options.language_change.connect(_on_language_change)
	_main_game.options.pixelization_level_change.connect(_on_pixelization_level_change)
	_main_game.options.mouse_sensitivity_change.connect(_on_mouse_sensitivity_change)


func _connect_ui_signals() -> void:
	%VolumeUpButton.pressed.connect(_on_volume_up_pressed)
	%VolumeDownButton.pressed.connect(_on_volume_down_pressed)
	%FullscreenCheckButton.toggled.connect(_on_fullscreen_toggled)
	%AspectRatioDropButton.item_selected.connect(_on_aspect_ratio_selected)
	%LanguageDropButton.item_selected.connect(_on_language_selected)
	%PixelizationUpButton.pressed.connect(_on_pixelization_up_pressed)
	%PixelizationDownButton.pressed.connect(_on_pixelization_down_pressed)
	%MouseSensitivitySlider.value_changed.connect(_on_mouse_sensitivity_changed)
	%SaveSettingsButton.pressed.connect(_on_save_settings_pressed)
	%ExitGameButton.pressed.connect(_on_exit_game_pressed)
	

func _on_volume_change(volume: Dictionary[String, int]) -> void:
	print("Volume changed to: %s" % volume)


func _on_aspect_ratio_change(aspect_ratio: Vector2) -> void:
	print("Aspect ratio changed to: %s" % aspect_ratio)


func _on_fullscreen_change(fullscreen: bool) -> void:
	print("Fullscreen changed to: %s" % fullscreen)


func _on_language_change(language: StringName) -> void:
	print("Language changed to: %s" % language)


func _on_pixelization_level_change(pixelization_level: int) -> void:
	print("Pixelization level changed to: %s" % pixelization_level)


func _on_mouse_sensitivity_change(mouse_sensitivity: int) -> void:
	print("Mouse sensitivity changed to: %s" % mouse_sensitivity)


func _on_volume_up_pressed() -> void:
	print("Volume Up button pressed")


func _on_volume_down_pressed() -> void:
	print("Volume Down button pressed")


func _on_fullscreen_toggled(button_pressed: bool) -> void:
	print("Fullscreen toggled: %s" % button_pressed)


func _on_aspect_ratio_selected(index: int) -> void:
	print("Aspect ratio selected: %d" % index)


func _on_language_selected(index: int) -> void:
	print("Language selected: %d" % index)


func _on_pixelization_up_pressed() -> void:
	print("Pixelization Up button pressed")


func _on_pixelization_down_pressed() -> void:
	print("Pixelization Down button pressed")


func _on_mouse_sensitivity_changed(value: float) -> void:
	print("Mouse sensitivity changed to: %f" % value)


func _on_save_settings_pressed() -> void:
	print("Save Settings button pressed")


func _on_exit_game_pressed() -> void:
	print("Exit Game button pressed")

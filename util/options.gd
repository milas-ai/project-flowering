class_name Options
extends Resource


signal volume_change(volume: Dictionary[String, int])
signal aspect_ratio_change(aspect_ratio: Vector2)
signal fullscreen_change(fullscreen: bool)
signal language_change(language: StringName)
signal pixelization_level_change(pixelization_level: int)
signal mouse_sensitivity_change(mouse_sensitivity: int)

var volume: Dictionary[String, int]:
	set(value):
		volume = value
		emit_signal("volume_change", volume)
var aspect_ratio: Vector2:
	set(value):
		aspect_ratio = value
		emit_signal("aspect_ratio_change", aspect_ratio)
var fullscreen: bool:
	set(value):
		fullscreen = value
		emit_signal("fullscreen_change", fullscreen)
var language: StringName:
	set(value):
		language = value
		emit_signal("language_change", language)
var pixelization_level: int:
	set(value):
		pixelization_level = value
		emit_signal("pixelization_level_change", pixelization_level)
var mouse_sensitivity: int:
	set(value):
		mouse_sensitivity = value
		emit_signal("mouse_sensitivity_change", mouse_sensitivity)


func _init(data: Dictionary = {}):
	volume.assign(data.get("volume", {"master": 100, "music": 100, "sfx": 100}))
	aspect_ratio = data.get("aspect_ratio", Vector2(16, 9))
	fullscreen = data.get("fullscreen", false)
	language = data.get("language", "pt")
	pixelization_level = data.get("pixelization_level", 1)
	mouse_sensitivity = data.get("mouse_sensitivity", 4)


func _to_dict() -> Dictionary:
	return {
		"volume": volume,
		"aspect_ratio": aspect_ratio,
		"fullscreen": fullscreen,
		"language": language,
		"pixelization_level": pixelization_level,
		"mouse_sensitivity": mouse_sensitivity
	}

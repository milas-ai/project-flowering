class_name Options
extends Resource


signal volume_change(volume: Dictionary[String, int])
signal aspect_ratio_change(retro_aspect_ratio: bool)
signal fullscreen_change(fullscreen: bool)
signal language_change(language: StringName)
signal pixelization_level_change(pixelization_level: int)
signal mouse_sensitivity_change(mouse_sensitivity: int)

const LANGUAGE_OPTIONS: Array[StringName] = ["pt", "en", "es"]

var volume: Dictionary[String, int]:
	set(value):
		volume = value
		emit_signal("volume_change", volume)
var retro_aspect_ratio: bool:
	set(value):
		retro_aspect_ratio = value
		emit_signal("aspect_ratio_change", retro_aspect_ratio)
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


static func language_index_to_string(index: int) -> StringName:
	if index < 0 or index >= LANGUAGE_OPTIONS.size():
		push_error("Invalid language index: %d" % index)
		return LANGUAGE_OPTIONS[0]
	return LANGUAGE_OPTIONS[index]


static func language_string_to_index(language_string: StringName) -> int:
	var index: int = LANGUAGE_OPTIONS.find(language_string)
	if index == -1:
		push_error("Invalid language: %s" % language_string)
		return 0
	return index


func _init(data: Dictionary = {}):
	volume.assign(data.get("volume", {"master": 100, "music": 100, "sfx": 100}))
	retro_aspect_ratio = data.get("retro_aspect_ratio", true)
	fullscreen = data.get("fullscreen", true)
	language = data.get("language", "pt")
	pixelization_level = data.get("pixelization_level", 5)
	mouse_sensitivity = data.get("mouse_sensitivity", 5)


func to_dict() -> Dictionary:
	return {
		"volume": volume,
		"retro_aspect_ratio": retro_aspect_ratio,
		"fullscreen": fullscreen,
		"language": language,
		"pixelization_level": pixelization_level,
		"mouse_sensitivity": mouse_sensitivity
	}

class_name Options
extends Resource


signal volume_change(volume: Dictionary[String, int])
signal aspect_ratio_change(aspect_ratio: Vector2)
signal fullscreen_change(fullscreen: bool)
signal language_change(language: StringName)
signal pixelization_level_change(pixelization_level: int)
signal mouse_sensitivity_change(mouse_sensitivity: int)

const LANGUAGE_OPTIONS: Array[StringName] = ["pt", "en"]
const ASPECT_RATIO_OPTIONS: Array[Vector2] = [Vector2(3, 4), Vector2(16, 9), Vector2(21, 9)]


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


static func aspect_ratio_index_to_vector(index: int) -> Vector2:
	if index < 0 or index >= ASPECT_RATIO_OPTIONS.size():
		push_error("Invalid aspect ratio index: %d" % index)
		return ASPECT_RATIO_OPTIONS[0]
	return ASPECT_RATIO_OPTIONS[index]


static func aspect_ratio_vector_to_index(aspect_ratio_vector: Vector2) -> int:
	var index: int = ASPECT_RATIO_OPTIONS.find(aspect_ratio_vector)
	if index == -1:
		push_error("Invalid aspect ratio: %s" % aspect_ratio_vector)
		return 0
	return index


func _init(data: Dictionary = {}):
	volume.assign(data.get("volume", {"master": 100, "music": 100, "sfx": 100}))
	aspect_ratio = data.get("aspect_ratio", Vector2(16, 9))
	fullscreen = data.get("fullscreen", false)
	language = data.get("language", "pt")
	pixelization_level = data.get("pixelization_level", 1)
	mouse_sensitivity = data.get("mouse_sensitivity", 4)


func to_dict() -> Dictionary:
	return {
		"volume": volume,
		"aspect_ratio": aspect_ratio,
		"fullscreen": fullscreen,
		"language": language,
		"pixelization_level": pixelization_level,
		"mouse_sensitivity": mouse_sensitivity
	}

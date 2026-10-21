class_name Options
extends Resource


signal volume_change(volume: Dictionary[String, int])
signal aspect_ratio_change(aspect_ratio: Vector2)
signal fullscreen_change(fullscreen: bool)
signal language_change(language: StringName)
signal pixelation_level_change(pixelation_level: int)

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
var pixelation_level: int:
	set(value):
		pixelation_level = value
		emit_signal("pixelation_level_change", pixelation_level)


func _init(data: Dictionary = {}):
	volume.assign(data.get("volume", {"master": 100, "music": 100, "sfx": 100}))
	aspect_ratio = data.get("aspect_ratio", Vector2(16, 9))
	fullscreen = data.get("fullscreen", false)
	language = data.get("language", "pt")
	pixelation_level = data.get("pixelation_level", 1)


func _to_dict() -> Dictionary:
	return {
		"volume": volume,
		"aspect_ratio": aspect_ratio,
		"fullscreen": fullscreen,
		"language": language,
		"pixelation_level": pixelation_level
	}

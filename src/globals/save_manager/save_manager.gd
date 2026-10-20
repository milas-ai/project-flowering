extends Node


const SAVE_FILE_PATH: String = "user://save.dat"

class Options:
	var volume: Dictionary[String, int]
	var aspect_ratio: Vector2
	var fullscreen: bool
	var language: StringName
	var pixelation_level: int

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

class SaveData:
	var stage_uid: String
	var options: Options

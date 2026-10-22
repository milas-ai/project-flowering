extends Node


const SAVE_FILE_PATH: String = "user://save.dat"


func save(data: SaveData) -> void:
	var file := FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(data.stage_uid)
		file.store_var(data.options.to_dict())
	else:
		push_error("Failed to open save file for writing.")
	file.close()


func load() -> SaveData:
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		push_warning("Save file does not exist.")
		return null
	
	var file := FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if file:
		var data: SaveData = SaveData.new()
		data.stage_uid = file.get_var()
		data.options = Options.new(file.get_var())
		file.close()
		return data
	else:
		push_error("Failed to open save file.")
		return null


func delete_save() -> void:
	if FileAccess.file_exists(SAVE_FILE_PATH):
		DirAccess.remove_absolute(SAVE_FILE_PATH)


class SaveData:
	var stage_uid: String
	var options: Options

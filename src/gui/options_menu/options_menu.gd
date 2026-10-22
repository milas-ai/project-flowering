extends Control


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

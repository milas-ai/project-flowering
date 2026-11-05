class_name HudRoot
extends Control


@onready var _main_game: MainGame = $/root/MainGame
@onready var _dialog_box: DialogBox = $DialogBox


func load_main_stage_hud() -> void:
	var health_container_scene: PackedScene = ResourceLoader.load(SceneUID.GUI.HEALTH_CONTAINER)
	var health_container: HBoxContainer = health_container_scene.instantiate()
	add_child(health_container)
	_main_game.player.update_health.connect(health_container._on_player_update_health)


func display_dialog(dialog_text: String) -> void:
	get_tree().paused = true
	_dialog_box.process_mode = PROCESS_MODE_INHERIT
	_dialog_box.display_dialog(dialog_text)


func _on_dialog_box_dialog_finished() -> void:
	_dialog_box.process_mode = PROCESS_MODE_DISABLED
	get_tree().paused = false

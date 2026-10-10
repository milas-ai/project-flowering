class_name HudRoot
extends Control


@onready var main_game: MainGame = $/root/MainGame


func load_main_stage_hud() -> void:
	var health_container_scene: PackedScene = ResourceLoader.load(SceneUID.GUI.HEALTH_CONTAINER)
	var health_container: HBoxContainer = health_container_scene.instantiate()
	add_child(health_container)
	main_game.player.update_health.connect(health_container._on_player_update_health)

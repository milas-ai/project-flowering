class_name TransitionArea
extends Area3D


@export_enum(
		"Gym:-1", 
		"Mountain",
) var target_stage: int = -1

@onready var _main_game: MainGame = $/root/MainGame


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(_body: Node3D) -> void:
	_main_game.transition_to_stage(_main_game.stage_id_to_uid(target_stage))
	
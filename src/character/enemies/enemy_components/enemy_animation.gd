extends Node

@export var enemy: Enemy
@export var model: Node3D


func _process(_delta: float) -> void:
	if (enemy.horizontal_direction.length() > 0.1):
		model.look_at(model.global_position + enemy.horizontal_direction, Vector3.UP)

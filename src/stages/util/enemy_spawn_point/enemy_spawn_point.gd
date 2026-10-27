@abstract
class_name EnemySpawnPoint
extends Marker3D


@export var steady: bool = false


func _ready() -> void:
	add_to_group("enemy_spawn_points")


@abstract func apply_enemy_properties(enemy: Enemy) -> void

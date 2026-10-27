@abstract
class_name EnemySpawnPoint
extends Marker3D


@export var steady: bool = false


func _ready() -> void:
	add_to_group("enemy_spawn_points")


func setup_enemy(enemy: Enemy) -> void:
	enemy.steady = steady
	enemy.position = global_position
	_apply_enemy_properties(enemy)


@abstract func _apply_enemy_properties(enemy: Enemy) -> void

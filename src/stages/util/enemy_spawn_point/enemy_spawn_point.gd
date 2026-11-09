@abstract
class_name EnemySpawnPoint
extends Marker3D

## Steady enemies will not move from their spawn point.
@export var steady: bool = false
## Percentage increase to the enemy's attack range.
@export var attack_range_increase: float = 0.0


func _ready() -> void:
	add_to_group("enemy_spawn_points")


func setup_enemy(enemy: Enemy) -> void:
	enemy.steady = steady
	enemy.attack_range_increase = attack_range_increase
	enemy.position = global_position
	_apply_enemy_properties(enemy)


@abstract func _apply_enemy_properties(enemy: Enemy) -> void

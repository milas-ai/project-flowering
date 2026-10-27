class_name AntSpawnPoint
extends EnemySpawnPoint


@export var attack_cooldown: float = BaseStat.ENEMY.ANT.COOLDOWN


func apply_enemy_properties(enemy: Enemy) -> void:
	enemy.attack_cooldown = attack_cooldown
	enemy.steady = steady

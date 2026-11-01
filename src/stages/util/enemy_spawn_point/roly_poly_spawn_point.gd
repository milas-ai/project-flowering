class_name RolyPolySpawnPoint
extends EnemySpawnPoint


@export var attack_cooldown: float = BaseStat.ENEMY.ROLY_POLY.COOLDOWN


func _apply_enemy_properties(enemy: Enemy) -> void:
	enemy.attack_cooldown = attack_cooldown

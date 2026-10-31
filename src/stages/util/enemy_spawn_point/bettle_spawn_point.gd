class_name BettleSpawnPoint
extends EnemySpawnPoint


@export var bullet_speed: float = BaseStat.ENEMY.BETTLE.BULLET_SPEED
@export var attack_cooldown: float = BaseStat.ENEMY.BETTLE.COOLDOWN


func _apply_enemy_properties(enemy: Enemy) -> void:
	enemy.attack_cooldown = attack_cooldown
	enemy._bullet_speed = bullet_speed

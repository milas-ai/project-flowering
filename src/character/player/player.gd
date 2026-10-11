class_name Player
extends Character


signal update_health(health: int)

var _health: int = BaseStat.PLAYER.HEALTH:
	set(value):
		_health = value
		emit_signal("update_health", _health)


func take_damage(amount: int) -> void:
	_health -= amount
	if _health <= 0:
		get_tree().quit()

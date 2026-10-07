class_name Player
extends Character


const FRICTION: float = 10
const SLIDE_FRICTION: float = 1.0

signal update_health(health)


func take_damage(amount: int) -> void:
	_health -= amount
	emit_signal("update_health", _health)
	if _health <= 0:
		get_tree().quit()

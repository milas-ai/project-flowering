extends Character
class_name Player


const FRICTION: float = 10
const SLIDE_FRICTION: float = 1.0

signal update_health(health)


func take_damage(amount: int) -> void:
	health -= amount
	emit_signal("update_health", health)
	if health <= 0:
		get_tree().quit()

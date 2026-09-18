extends Character
class_name Player


const friction: float = 10
const slide_friction: float = 1.0
var max_health = BASE_HEALTH

signal update_health(health)


func take_damage(amount: int) -> void:
	health -= amount
	emit_signal("update_health", health, max_health)
	if health <= 0:
		get_tree().quit()

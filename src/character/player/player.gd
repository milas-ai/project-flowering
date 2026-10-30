class_name Player
extends Character


signal update_health(health: int)

var input_direction := Vector3.ZERO


var _health: int = BaseStat.PLAYER.HEALTH:
	set(value):
		_health = value
		emit_signal("update_health", _health)


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	horizontal_velocity = velocity * Vector3(1,0,1)
	vertical_velocity = velocity * Vector3(0,1,0)


func take_damage(amount: int) -> void:
	_health -= amount
	if _health <= 0:
		get_tree().quit()

class_name Player
extends Character


signal update_health(health: int)
signal dead()

var _health: int = BaseStat.PLAYER.HEALTH:
	set(value):
		_health = value
		emit_signal("update_health", _health)


func _process(_delta: float) -> void:
	RenderingServer.global_shader_parameter_set("player_position", global_position)


func take_damage(amount: int) -> void:
	_health -= amount
	if _health <= 0:
		emit_signal("dead")

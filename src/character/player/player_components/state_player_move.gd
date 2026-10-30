class_name StatePlayerMove
extends State


var _speed: float = BaseStat.PLAYER.SPEED


func enter() -> void:
	body.animation_player.play("Walk")


func update(delta: float) -> void:
	body.process_horizontal_movement(delta, _speed)


func exit() -> void:
	_speed = BaseStat.PLAYER.SPEED


func start_running() -> void:
	body.animation_player.play("Run")
	_speed = BaseStat.PLAYER.SPEED * 2


func stop_running() -> void:
	body.animation_player.play("Walk")
	_speed = BaseStat.PLAYER.SPEED

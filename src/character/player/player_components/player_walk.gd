class_name PlayerWalk
extends Node


var _speed: float
var _speed_multiplier: float

@onready var _player_input: PlayerInput = $"../../Input"
@onready var _player: Player = $"../.."
@onready var _player_slide: PlayerSlide = $"../Slide"


func _physics_process(delta: float) -> void:
	# Velocity's components reflected back for collisions
	_player.horizontal_velocity = _player.velocity * Vector3(1,0,1)
	_player.vertical_velocity = _player.velocity * Vector3(0,1,0)
	
	if _player_input.sliding and _player_slide.is_sliding:
		return
	
	_speed = _calculate_speed()
	_walk(delta)


func _calculate_speed() -> float:
	_speed_multiplier = 1 + int(_player_input.running)
	return BaseStat.PLAYER.SPEED * _speed_multiplier


func _walk(delta: float) -> void:
	if _player.input_direction:
		_speed = _calculate_speed()
		if _player.horizontal_velocity.length() > 2 * _speed:
			_player.horizontal_velocity = _player.horizontal_velocity.lerp(
					_player.input_direction * _speed, BaseStat.PLAYER.SLIDE_FRICTION * delta
			)
		else:
			_player.horizontal_velocity = _player.input_direction * _speed
	else:
		_player.horizontal_velocity = _player.horizontal_velocity.lerp(Vector3.ZERO, BaseStat.PLAYER.FRICTION * delta)

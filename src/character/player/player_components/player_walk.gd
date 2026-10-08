class_name PlayerWalk
extends Node


const TURNING_SPEED: float = 7

var _speed_multiplier: float = 1
var _target_direction := Vector3.ZERO

@onready var _player_input: PlayerInput = $"../../Input"
@onready var _player: Player = $"../.."
@onready var _player_slide: PlayerSlide = $"../Slide"


func _physics_process(delta: float) -> void:
	# Velocity's components reflected back for collisions
	_player.horizontal_velocity = _player.velocity * Vector3(1,0,1)
	_player.vertical_velocity = _player.velocity * Vector3(0,1,0)
	
	if _player_input.sliding and _player_slide.is_sliding:
		return
	
	_player.speed = _calculate_speed()
	_player.horizontal_direction = _calculate_direction(delta)
	_walk(delta)


func _calculate_speed() -> float:
	_speed_multiplier = 1 + int(_player_input.running)
	return _player.BASE_SPEED * _speed_multiplier


func _calculate_direction(delta: float) -> Vector3:
	var direction: Vector3 = (_player.transform.basis * Vector3(_player_input.h_input_dir.x,0,_player_input.h_input_dir.y)).normalized()
	_target_direction = Math.lerpfd(_target_direction, direction, TURNING_SPEED, delta)
	return _target_direction * Vector3(1,0,1)


func _walk(delta: float) -> void:
	if _player.horizontal_direction:
		_player.speed = _calculate_speed()
		if _player.horizontal_velocity.length() > 2 * _player.speed:
			_player.horizontal_velocity = _player.horizontal_velocity.lerp(_player.horizontal_direction * _player.speed, _player.SLIDE_FRICTION * delta)
		else:
			_player.horizontal_velocity = _player.horizontal_direction * _player.speed
	else:
		_player.horizontal_velocity = _player.horizontal_velocity.lerp(Vector3.ZERO, _player.FRICTION * delta)

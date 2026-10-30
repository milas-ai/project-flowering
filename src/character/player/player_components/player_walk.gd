class_name PlayerWalk
extends Node


var _speed: float
var _speed_multiplier: float

@onready var _player_input: PlayerInput = $"../../Input"
@onready var _player: Player = $"../.."
@onready var _player_slide: PlayerSlide = $"../Slide"


func _physics_process(delta: float) -> void:
	if _player_input.sliding and _player_slide.is_sliding:
		return
	
	_speed = _calculate_speed()
	_player.process_horizontal_movement(delta, _player.input_direction, _speed)


func _calculate_speed() -> float:
	_speed_multiplier = 1 + int(_player_input.running)
	return BaseStat.PLAYER.SPEED * _speed_multiplier

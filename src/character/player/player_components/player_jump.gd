class_name PlayerJump
extends Node


@onready var _player: Player = $"../.."
@onready var _player_slide: PlayerSlide = $"../Slide"
@onready var _jump_buff_timer: Timer = $JumpBuffer
@onready var _coyote_timer: Timer = $CoyoteTime

var _was_on_floor: bool = false
var _jump_buffer: bool = false
var _coyote_time: bool = false


func _on_player_input_jump_pressed() -> void:
	_jump_buffer = true
	_jump_buff_timer.start()


func _physics_process(_delta: float) -> void:
	_update_coyote()
	if _jump_buffer and _coyote_time:
		_jump(_player.JUMP_VELOCITY)


func _jump(impulse: float) -> void:
	_player.vertical_velocity.y = impulse
	_jump_buffer = false

	if _player_slide.is_sliding:
		_player_slide.stop_slide()


func _update_coyote() -> void:
	if _player.is_on_floor():
		_coyote_time = true
		_was_on_floor = true
	else:
		if _was_on_floor:
			_coyote_timer.start()
		_was_on_floor = false


func _on_jump_buffer_timeout() -> void:
	_jump_buffer = false


func _on_coyote_time_timeout() -> void:
	_coyote_time = false

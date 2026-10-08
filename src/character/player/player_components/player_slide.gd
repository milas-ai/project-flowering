class_name PlayerSlide
extends Node


const BASE_SLIDE_SPEED: float = 8.0
const MAX_SLIDE_SPEED: float = 100.0
const SLOPE_ACCELERATION: float = 20.0
const STEER_INFLUENCE: float = 1.0

var is_sliding: bool = false

@onready var _player_input: PlayerInput = $"../../Input"
@onready var _player: Player = $"../.."
@onready var _slide_cooldown: Timer = $SlideCooldown


func _physics_process(delta: float) -> void:
	var floor_normal: Vector3 = _player.get_floor_normal()
	var is_on_slope: bool = _player.is_on_floor() and floor_normal.y < 0.98

	if _player_input.sliding and not is_sliding and is_on_slope:
		_start_slide()

	if is_sliding:
		if not _player.is_on_floor() or not _player_input.sliding:
			_stop_slide()
			return

		if not is_on_slope:
			_stop_slide()
			return

		var downhill_dir := Vector3.DOWN.slide(floor_normal).normalized()
		
		var current_speed: float = (_player.horizontal_velocity+_player.vertical_velocity).length()
		
		current_speed = move_toward(current_speed, MAX_SLIDE_SPEED, SLOPE_ACCELERATION * delta)
		
		var final_slide_dir: Vector3 = downhill_dir
		
		if _player.horizontal_direction != Vector3.ZERO:
			var slope_right: Vector3 = downhill_dir.cross(floor_normal).normalized()
			
			var steer_side_amount: float = _player.horizontal_direction.dot(slope_right)
			
			final_slide_dir = (downhill_dir + (slope_right * steer_side_amount * STEER_INFLUENCE)).normalized()
			
			final_slide_dir = final_slide_dir.slide(floor_normal).normalized()

		_player.horizontal_velocity = final_slide_dir * current_speed * Vector3(1,0,1)
		_player.vertical_velocity = final_slide_dir * current_speed * Vector3(0,1,0)


func _start_slide() -> void:
	if _slide_cooldown.time_left > 0:
		return
	is_sliding = true
	var floor_normal: Vector3 = _player.get_floor_normal()
	var downhill_dir := Vector3.DOWN.slide(floor_normal).normalized()
	
	var starting_speed: float = max(_player.horizontal_velocity.length(), BASE_SLIDE_SPEED)
	
	_player.horizontal_velocity = downhill_dir * starting_speed * Vector3(1,0,1)
	_player.vertical_velocity = downhill_dir * starting_speed * Vector3(0,1,0)


func _stop_slide() -> void:
	is_sliding = false
	_slide_cooldown.start()

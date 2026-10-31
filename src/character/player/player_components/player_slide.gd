class_name PlayerSlide
extends Node


var is_sliding: bool = false
var _target_direction := Vector3.ZERO
var _current_speed: float = 0.0

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
			stop_slide()
			return

		if not is_on_slope:
			stop_slide()
			return

		var downhill_dir := Vector3.DOWN.slide(floor_normal).normalized()
		
		_current_speed = move_toward(_current_speed, BaseStat.PLAYER.MAX_SLIDE_SPEED, BaseStat.PLAYER.SLOPE_ACCELERATION * delta)
		
		var final_slide_dir: Vector3 = downhill_dir

		_player.horizontal_direction = _calculate_direction(delta)
		
		if _player.horizontal_direction != Vector3.ZERO:
			var slope_right: Vector3 = downhill_dir.cross(floor_normal).normalized()
			
			var steer_side_amount: float = _player.horizontal_direction.dot(slope_right)
			
			final_slide_dir = (downhill_dir + (slope_right * steer_side_amount * BaseStat.PLAYER.STEER_INFLUENCE)).normalized()
			
			final_slide_dir = final_slide_dir.slide(floor_normal).normalized()

		_player.horizontal_velocity = final_slide_dir * _current_speed * Vector3(1,0,1)
		_player.vertical_velocity = final_slide_dir * _current_speed * Vector3(0,1,0)

func _calculate_direction(delta: float) -> Vector3:
	var direction := (
			Vector3(_player_input.h_input_dir.x,0,_player_input.h_input_dir.y) * _player.transform.basis
	).normalized()
	_target_direction = Math.lerpfd(_target_direction, direction, BaseStat.PLAYER.TURNING_SPEED, delta)
	return _target_direction * Vector3(1,0,1)

func _start_slide() -> void:
	if _slide_cooldown.time_left > 0:
		return
	is_sliding = true
	var floor_normal: Vector3 = _player.get_floor_normal()
	var downhill_dir := Vector3.DOWN.slide(floor_normal).normalized()
	
	var starting_speed: float = max(_player.horizontal_velocity.length(), BaseStat.PLAYER.SLIDE_SPEED)
	_current_speed = starting_speed
	
	_player.horizontal_velocity = downhill_dir * starting_speed * Vector3(1,0,1)
	_player.vertical_velocity = downhill_dir * starting_speed * Vector3(0,1,0)


func stop_slide() -> void:
	is_sliding = false
	_slide_cooldown.start()

class_name StatePlayerSlide
extends State


var _target_direction := Vector3.ZERO
var _current_speed: float = 0.0


func enter() -> void:
	body.animation_player.play("Slide")
	var floor_normal: Vector3 = body.get_floor_normal()
	var downhill_dir := Vector3.DOWN.slide(floor_normal).normalized()
	
	var starting_speed: float = max(body.horizontal_velocity.length(), BaseStat.PLAYER.SLIDE_SPEED)
	_current_speed = starting_speed
	
	body.horizontal_velocity = downhill_dir * starting_speed * Vector3(1,0,1)
	body.vertical_velocity = downhill_dir * starting_speed * Vector3(0,1,0)


func update(delta: float) -> void:
	if not body.is_on_floor() or not (body.is_on_floor() and body.get_floor_normal().y < 0.98):
		state_machine.transition_to("StatePlayerIdle")

	var floor_normal: Vector3 = body.get_floor_normal()
	var downhill_dir := Vector3.DOWN.slide(floor_normal).normalized()
	
	_current_speed = move_toward(_current_speed, BaseStat.PLAYER.MAX_SLIDE_SPEED, BaseStat.PLAYER.SLOPE_ACCELERATION * delta)
	
	var final_slide_dir: Vector3 = downhill_dir

	body.horizontal_direction = _calculate_direction(delta)
	
	if body.horizontal_direction != Vector3.ZERO:
		var slope_right: Vector3 = downhill_dir.cross(floor_normal).normalized()
		
		var steer_side_amount: float = body.horizontal_direction.dot(slope_right)
		
		final_slide_dir = (downhill_dir + (slope_right * steer_side_amount * BaseStat.PLAYER.STEER_INFLUENCE)).normalized()
		
		final_slide_dir = final_slide_dir.slide(floor_normal).normalized()

	body.horizontal_velocity = final_slide_dir * _current_speed * Vector3(1,0,1)
	body.vertical_velocity = final_slide_dir * _current_speed * Vector3(0,1,0)


func exit() -> void:
	_target_direction = Vector3.ZERO
	_current_speed = 0.0


func _calculate_direction(delta: float) -> Vector3:
	var direction : Vector3 = (
			Vector3(body.input_direction.x,0,body.input_direction.y) * body.transform.basis
	).normalized()
	_target_direction = Math.lerpfd(_target_direction, direction, BaseStat.PLAYER.TURNING_SPEED, delta)
	return _target_direction * Vector3(1,0,1)

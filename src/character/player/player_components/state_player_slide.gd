class_name StatePlayerSlide
extends State


var _current_speed: float
var _exit_slide: bool
var _sudden_stop: bool


func enter() -> void:
	body.animation_player.play("Slide")
	
	_current_speed = max(BaseStat.PLAYER.SLIDE_SPEED, body.horizontal_velocity.length())
	_exit_slide = false
	_sudden_stop = true
	get_tree().create_timer(0.1).timeout.connect(
		func(): _sudden_stop = false
	)

func update(delta: float) -> void:
	if not body.is_on_floor() or not (body.is_on_floor() and body.get_floor_normal().y < 0.98):
		if not _exit_slide:
			get_tree().create_timer(BaseStat.PLAYER.SLIDE_COYOTE_TIME).timeout.connect(
				func(): state_machine.transition_to("StatePlayerFall")
			)
			_exit_slide = true
		if _sudden_stop: # Prevent the player from glitching between a ramp and a flat surface
			get_tree().create_timer(0.05).timeout.connect(
				func(): state_machine.transition_to("StatePlayerIdle")
			)
		return

	body.process_horizontal_movement(delta, body.input_direction, BaseStat.PLAYER.SPEED)
	body.process_rotation(true)
	
	var floor_normal: Vector3 = body.get_floor_normal()
	var downhill_dir := Vector3.DOWN.slide(floor_normal).normalized()
	
	_current_speed = move_toward(_current_speed, BaseStat.PLAYER.MAX_SLIDE_SPEED, BaseStat.PLAYER.SLOPE_ACCELERATION * delta)
	
	var final_slide_dir: Vector3 = downhill_dir
	
	if body.input_direction.length() > 0.1:
		var slope_right: Vector3 = downhill_dir.cross(floor_normal).normalized()
		
		var steer_side_amount: float = body.input_direction.dot(slope_right)
		
		final_slide_dir = (downhill_dir + (slope_right * steer_side_amount * BaseStat.PLAYER.STEER_INFLUENCE)).normalized()
		
		final_slide_dir = final_slide_dir.slide(floor_normal).normalized()

	body.horizontal_velocity = final_slide_dir * _current_speed * Vector3(1,0,1)
	body.vertical_velocity = final_slide_dir * _current_speed * Vector3(0,1,0)


func exit() -> void:
	_current_speed = 0.0

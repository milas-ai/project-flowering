extends Node
class_name PlayerSlide

@onready var player_input: PlayerInput = $"../../Input"
@onready var player: Player = $"../.."

const BASE_SLIDE_SPEED: float = 10.0
const MAX_SLIDE_SPEED: float = 100.0
const SLOPE_ACCELERATION: float = 50.0
const STEER_INFLUENCE: float = 1.0

var is_sliding: bool = false


func _physics_process(delta: float) -> void:
	var floor_normal = player.get_floor_normal()
	var is_on_slope = player.is_on_floor() and floor_normal.y < 0.98

	if player_input.sliding and not is_sliding and is_on_slope:
		start_slide()

	if is_sliding:
		if not player.is_on_floor() or not player_input.sliding:
			stop_slide()
			return

		if not is_on_slope:
			stop_slide()
			return

		var downhill_dir = Vector3.DOWN.slide(floor_normal).normalized()
		
		var current_speed = player.horizontal_velocity.length()
		
		current_speed = move_toward(current_speed, MAX_SLIDE_SPEED, SLOPE_ACCELERATION * delta)
		
		var final_slide_dir = downhill_dir
		
		if player.horizontal_direction != Vector3.ZERO:
			var slope_right = downhill_dir.cross(floor_normal).normalized()
			
			var steer_side_amount = player.horizontal_direction.dot(slope_right)
			
			final_slide_dir = (downhill_dir + (slope_right * steer_side_amount * STEER_INFLUENCE)).normalized()
			
			final_slide_dir = final_slide_dir.slide(floor_normal).normalized()

		player.horizontal_velocity = final_slide_dir * current_speed


func start_slide() -> void:
	is_sliding = true
	var floor_normal = player.get_floor_normal()
	var downhill_dir = Vector3.DOWN.slide(floor_normal).normalized()
	
	var starting_speed = max(player.horizontal_velocity.length(), BASE_SLIDE_SPEED)
	
	player.horizontal_velocity = downhill_dir * starting_speed


func stop_slide() -> void:
	is_sliding = false

extends Node
class_name PlayerWalk

@onready var player_input: PlayerInput = $"../../Input"
@onready var player: Player = $"../.."
@onready var player_slide: PlayerSlide = $"../Slide"

var speed_multiplier: float = 1
var target_direction: Vector3 = Vector3.ZERO

const TURNING_SPEED: float = 7


func _physics_process(delta: float) -> void:
	player.speed = calculate_speed()
	player.horizontal_direction = calculate_direction(delta)
	if player_input.sliding and player_slide.is_sliding:
		return

	walk(delta)


func calculate_speed() -> float:
	speed_multiplier = 1 + int(player_input.running)
	return player.BASE_SPEED * speed_multiplier


func calculate_direction(delta: float) -> Vector3:
	var direction: Vector3 = (player.transform.basis * Vector3(player_input.h_input_dir.x,0,player_input.h_input_dir.y)).normalized()
	target_direction = Math.lerpfd(target_direction, direction, TURNING_SPEED, delta)
	return target_direction * Vector3(1,0,1)


func walk(delta: float) -> void:
	if player.horizontal_direction:
		player.speed = calculate_speed()
		if player.horizontal_velocity.length() > 2 * player.speed:
			player.horizontal_velocity = player.horizontal_velocity.lerp(player.horizontal_direction * player.speed, player.slide_friction * delta)
		else:
			player.horizontal_velocity = player.horizontal_direction * player.speed
	else:
		player.horizontal_velocity = player.horizontal_velocity.lerp(Vector3.ZERO, player.friction * delta)

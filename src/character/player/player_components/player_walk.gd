extends Node
class_name PlayerWalk


@onready var playerinput: PlayerInput = $"../../Input"
@onready var player: Player = $"../.."

var speed_multiplier: float = 1


func _physics_process(delta: float) -> void:
	player.speed = calculate_speed()
	player.horizontal_direction = calculate_direction()
	walk(delta)


func calculate_speed() -> float:
	speed_multiplier = 1 + int(playerinput.running)
	return player.BASE_SPEED * speed_multiplier


func calculate_direction() -> Vector3:
	var direction = (player.transform.basis * Vector3(playerinput.h_input_dir.x,0,playerinput.h_input_dir.y)).normalized()
	return direction * Vector3(1,0,1)


func walk(delta: float) -> void:
	if player.horizontal_direction:
		player.horizontal_velocity = player.horizontal_direction * player.speed
	else:
		player.horizontal_velocity = Math.lerpfd(player.horizontal_velocity, Vector3.ZERO, player.friction, delta)

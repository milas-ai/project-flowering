extends State

class_name StateChase

@onready var player: Player = $"../../../Player"
@onready var navigation_agent: NavigationAgent3D = $"../../NavigationAgent3D"

@export var desired_distance: float = 1.5


func _ready() -> void:
	navigation_agent.path_desired_distance = 1.5
	navigation_agent.target_desired_distance = desired_distance

func _enter() -> void:
	print("Entering StateChase")

func _update(_delta: float) -> void:
	if not body.player_on_far_sight:
		state_machine.transition_to("StateIdle")
		return

	navigation_agent.target_position = player.global_transform.origin
	if not navigation_agent.is_navigation_finished():
		body.horizontal_direction = navigation_agent.get_next_path_position() - body.global_transform.origin
		body.horizontal_direction.y = 0
		body.horizontal_velocity = body.horizontal_direction.normalized() * body.BASE_SPEED
		body.look_at(body.global_transform.origin + body.horizontal_direction, Vector3.UP)
	else:
		body.horizontal_velocity = Math.lerpfd(body.horizontal_velocity, Vector3.ZERO, body.friction, _delta)

func _exit() -> void:
	body.horizontal_direction = Vector3.ZERO
	body.horizontal_velocity = Vector3.ZERO

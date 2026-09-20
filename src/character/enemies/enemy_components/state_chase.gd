extends State
class_name StateChase


@export var desired_distance: float = 1.5

@onready var navigation_agent: NavigationAgent3D = $"../../NavigationAgent3D"
@onready var speed = body.SPEED if body.has_meta("SPEED") else body.BASE_SPEED


func _ready() -> void:
	navigation_agent.path_desired_distance = 1.5
	navigation_agent.target_desired_distance = desired_distance

func _enter() -> void:
	if body.player_on_far_sight:
		body.animation_player.play("walk")

func _update(_delta: float) -> void:
	if not body.player_on_far_sight:
		state_machine.transition_to("StateIdle")
		return

	navigation_agent.target_position = body.player.global_transform.origin
	if navigation_agent.is_navigation_finished() or body.player_on_near_sight:
		body.horizontal_velocity = Math.lerpfd(body.horizontal_velocity, Vector3.ZERO, body.friction, _delta)
		state_machine.transition_to("StateAttack")
		return

	body.horizontal_direction = navigation_agent.get_next_path_position() - body.global_transform.origin
	body.horizontal_direction.y = 0
	body.horizontal_velocity = body.horizontal_direction.normalized() * speed
	body.look_at(body.global_transform.origin + body.horizontal_direction, Vector3.UP)

func _exit() -> void:
	body.horizontal_direction = Vector3.ZERO
	body.horizontal_velocity = Vector3.ZERO

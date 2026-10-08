class_name StateChase
extends State


@export var _desired_distance: float = 1.5

@onready var _navigation_agent: NavigationAgent3D = $"../../NavigationAgent3D"


func _ready() -> void:
	_navigation_agent.path_desired_distance = 1.5
	_navigation_agent.target_desired_distance = _desired_distance


func enter() -> void:
	if body.player_on_far_sight:
		body.animation_player.play("walk")


func update(_delta: float) -> void:
	if not body.player_on_far_sight:
		state_machine.transition_to("StateIdle")
		return

	_navigation_agent.target_position = body.player.global_transform.origin
	if _navigation_agent.is_navigation_finished() or body.player_on_near_sight:
		body.horizontal_velocity = Math.lerpfd(body.horizontal_velocity, Vector3.ZERO, body.FRICTION, _delta)
		state_machine.transition_to("StateAttack")
		return

	body.horizontal_direction = _navigation_agent.get_next_path_position() - body.global_transform.origin
	body.horizontal_direction.y = 0
	body.horizontal_velocity = body.horizontal_direction.normalized() * body.SPEED
	body.look_at(body.global_transform.origin + body.horizontal_direction, Vector3.UP)


func exit() -> void:
	body.horizontal_direction = Vector3.ZERO
	body.horizontal_velocity = Vector3.ZERO

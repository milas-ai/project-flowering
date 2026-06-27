extends Node


@onready var enemy: Enemy = $".."
@onready var player: Player = $"../../Player"
@onready var navigation_agent: NavigationAgent3D = $"../NavigationAgent3D"


func _ready() -> void:
	navigation_agent.path_desired_distance = 1.5
	navigation_agent.target_desired_distance = 1.5

func _physics_process(delta: float) -> void:
	navigation_agent.target_position = player.global_transform.origin
	if navigation_agent.is_navigation_finished():
		enemy.horizontal_velocity = Math.lerpfd(enemy.horizontal_velocity, Vector3.ZERO, enemy.friction, delta)
		enemy.attack_player()
	elif not enemy.in_cooldown:
		enemy.horizontal_direction = navigation_agent.get_next_path_position() - enemy.global_transform.origin
		enemy.horizontal_direction.y = 0
		enemy.horizontal_velocity = enemy.horizontal_direction.normalized() * enemy.BASE_SPEED
		

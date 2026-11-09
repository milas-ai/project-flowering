@abstract
class_name Enemy
extends Character


@export var steady: bool = false
@export var attack_cooldown: float = 2.0
@export var attack_range_increase: float = 0.0

var player_on_far_sight: bool = false
var player_on_near_sight: bool = false
var _health: int

@onready var player: Player = $/root/MainGame.player
@onready var _state_machine: StateMachine = $StateMachine


@abstract func attack_player() -> void


func _ready() -> void:
	if attack_range_increase != 0.0:
		var near_sight_collision_shape: CollisionShape3D = $NearSight/CollisionShape3D
		var near_sight_shape: SphereShape3D = near_sight_collision_shape.shape.duplicate()
		near_sight_shape.radius += near_sight_shape.radius * attack_range_increase
		near_sight_collision_shape.shape = near_sight_shape


func take_damage(amount: int) -> void:
	_health -= amount
	if _health <= 0:
		queue_free()


func apply_stun() -> void:
	_state_machine.transition_to("StateEnemyStunned")


func _on_far_sight_body_entered(_body: Node3D) -> void:
	player_on_far_sight = true


func _on_far_sight_body_exited(_body: Node3D) -> void:
	player_on_far_sight = false


func _on_near_sight_body_entered(_body: Node3D) -> void:
	player_on_near_sight = true


func _on_near_sight_body_exited(_body: Node3D) -> void:
	player_on_near_sight = false

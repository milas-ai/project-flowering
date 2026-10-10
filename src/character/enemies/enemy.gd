@abstract
class_name Enemy
extends Character


@export var steady: bool = false
@export var attack_cooldown: float = 2.0

var player_on_far_sight: bool = false
var player_on_near_sight: bool = false
var _health: int

@onready var player: Player = $/root/MainGame.player
@onready var animation_player: AnimationPlayer = $CharacterModel/AnimationPlayer


@abstract func attack_player() -> void


func take_damage(amount: int) -> void:
	_health -= amount
	if _health <= 0:
		queue_free()


func _on_far_sight_body_entered(_body: Node3D) -> void:
	player_on_far_sight = true


func _on_far_sight_body_exited(_body: Node3D) -> void:
	player_on_far_sight = false


func _on_near_sight_body_entered(_body: Node3D) -> void:
	player_on_near_sight = true


func _on_near_sight_body_exited(_body: Node3D) -> void:
	player_on_near_sight = false

@abstract
class_name Enemy
extends Character


const FRICTION: float = 25

@export var steady: bool = false
@export var attack_cooldown: float = 2.0

var player_on_far_sight: bool = false
var player_on_near_sight: bool = false

@onready var player: Player = get_tree().get_root().get_node("MainGame").player
@onready var animation_player: AnimationPlayer = $CharacterModel/AnimationPlayer


func _on_far_sight_body_entered(_body: Node3D) -> void:
	player_on_far_sight = true


func _on_far_sight_body_exited(_body: Node3D) -> void:
	player_on_far_sight = false


func _on_near_sight_body_entered(_body: Node3D) -> void:
	player_on_near_sight = true


func _on_near_sight_body_exited(_body: Node3D) -> void:
	player_on_near_sight = false

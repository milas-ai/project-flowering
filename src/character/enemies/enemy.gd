extends Character
class_name Enemy

@onready var player: Player = $"../Player"

@export var attack_cooldown: float = 2.0
@export var near_sight_radius: float = 10.0
@export var far_sight_radius: float = 20.0

var player_on_far_sight: bool = false
var player_on_near_sight: bool = false

const friction: float = 25


func _ready() -> void:
	$"FarSight/CollisionShape3D".shape.radius = far_sight_radius
	$"NearSight/CollisionShape3D".shape.radius = near_sight_radius

func _on_far_sight_body_entered(_body: Node3D) -> void:
	player_on_far_sight = true

func _on_far_sight_body_exited(_body: Node3D) -> void:
	player_on_far_sight = false

func _on_near_sight_body_entered(_body: Node3D) -> void:
	player_on_near_sight = true

func _on_near_sight_body_exited(_body: Node3D) -> void:
	player_on_near_sight = false
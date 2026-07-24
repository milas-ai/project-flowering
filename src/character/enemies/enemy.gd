extends Character
class_name Enemy

@onready var player: Player = $"../Player"

var player_on_far_sight: bool = false
var player_on_near_sight: bool = false

const friction: float = 25


func _on_far_sight_body_entered(_body: Node3D) -> void:
	player_on_far_sight = true

func _on_far_sight_body_exited(_body: Node3D) -> void:
	player_on_far_sight = false

func _on_near_sight_body_entered(_body: Node3D) -> void:
	player_on_near_sight = true

func _on_near_sight_body_exited(_body: Node3D) -> void:
	player_on_near_sight = false

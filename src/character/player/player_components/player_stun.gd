extends Node
class_name PlayerStun


@onready var stun_area: Area3D = $"../../StunArea"
@onready var player_input: PlayerInput = $"../../Input"

var is_stunning: bool = false

const ENEMY_LAYER_BITMASK: int = 1 << (3 - 1)

func _ready():
	player_input.stun_pressed.connect(_on_player_input_stun_pressed)

func _on_player_input_stun_pressed():
	if not is_stunning:
		is_stunning = true
		var detected_bodies = stun_area.get_overlapping_bodies()
		for body in detected_bodies:
			if body.collision_layer & ENEMY_LAYER_BITMASK:
				if body.has_method("apply_stun"):
					body.apply_stun()
		
		get_tree().create_timer(0.8).timeout.connect(func(): is_stunning = false)
		

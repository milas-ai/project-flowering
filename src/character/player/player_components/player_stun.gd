extends Node
class_name PlayerStun


var is_stunning: bool = false

@onready var stun_area: Area3D = $"../../StunArea"


func _on_player_input_stun_pressed():
	if not is_stunning:
		is_stunning = true
		var detected_bodies: Array[Node3D] = stun_area.get_overlapping_bodies()
		for body in detected_bodies:
			if body.collision_layer & LayerBitmask.ENEMY:
				if body.has_method("apply_stun"):
					body.apply_stun()
		
		get_tree().create_timer(0.8).timeout.connect(func(): is_stunning = false)

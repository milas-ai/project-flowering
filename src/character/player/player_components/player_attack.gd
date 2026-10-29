class_name PlayerAttack
extends Node


var is_attacking: bool = false


func _on_player_input_attack_pressed():
	if not is_attacking:
		is_attacking = true
		get_tree().create_timer(0.45).timeout.connect(func(): is_attacking = false)

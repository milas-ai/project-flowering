class_name PlayerBlock
extends Node


var is_blocking: bool = false

@onready var shield := $"../../ShieldRigidBody3D"


func _on_player_input_block_pressed():
	is_blocking = true
	shield.process_mode = Node.PROCESS_MODE_INHERIT


func _on_player_input_block_released():
	is_blocking = false
	shield.process_mode = Node.PROCESS_MODE_DISABLED

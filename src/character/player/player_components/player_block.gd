class_name PlayerBlock
extends Node


var is_blocking: bool = false

@onready var _shield := $"../../ShieldRigidBody3D"


func _on_player_input_block_pressed():
	is_blocking = true
	_shield.process_mode = Node.PROCESS_MODE_INHERIT


func _on_player_input_block_released():
	is_blocking = false
	_shield.process_mode = Node.PROCESS_MODE_DISABLED

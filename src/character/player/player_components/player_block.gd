class_name PlayerBlock
extends Node


var is_blocking: bool = false


func _on_player_input_block_pressed():
	is_blocking = true


func _on_player_input_block_released():
	is_blocking = false

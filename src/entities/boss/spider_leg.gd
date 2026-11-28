class_name SpiderLeg
extends Node3D


@onready var _animation_player: AnimationPlayer = $Model/AnimationPlayer


func stomp() -> void:
	_animation_player.play("stomp")


func reset() -> void:
	_animation_player.play("RESET")
	await _animation_player.animation_finished

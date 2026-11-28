class_name SpiderLeg
extends Node3D


@onready var _animation_player: AnimationPlayer = $Model/AnimationPlayer


func _ready() -> void:
	_animation_player.play("RESET")


func stomp() -> void:
	_animation_player.play("stomp")

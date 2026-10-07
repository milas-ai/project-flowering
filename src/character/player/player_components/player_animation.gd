extends Node


@export var _player: Player
@export var _model: Node3D
@export var _slide_component: Node

@onready var _player_push: PlayerPush = $"../../Action/Push"

var is_stunning: bool = false


func _on_player_input_stun_pressed():
	is_stunning = true
	await get_tree().create_timer(0.8).timeout
	is_stunning = false


func _process(_delta: float) -> void:
	if _player.horizontal_direction.length() > 0.1:
		_model.look_at(_model.global_position + _player.horizontal_direction, Vector3.UP, true)
	var anim: AnimationPlayer = _model.get_child(1)	# TODO: Get this in propper way
	
	# TODO: Interpolate
	
	# TODO: Attack and poke animations
	if _slide_component.is_sliding:
		var floor_normal = _player.get_floor_normal()
		_model.look_at(_model.global_position + _player.horizontal_velocity, floor_normal, true)
		anim.play("Slide")
	elif not _player.is_on_floor():
		if _player.vertical_velocity.y > 0:
			anim.play("Jump")
		else:
			anim.play("Fall")
	elif _player_push.is_pushing:
		anim.play("Poke")
	elif is_stunning:
		anim.play("Stun")
	elif _player.horizontal_velocity.length() < 1:
		anim.play("Idle")
	elif not $"../../Input".running:
		anim.play("Walk")
	else:
		anim.play("Run")
	

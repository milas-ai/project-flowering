extends Node


@export var _player: Player
@export var _model: Node3D
@export var _shield: RigidBody3D
@export var _slide_component: PlayerSlide

@onready var _player_push: PlayerPush = $"../../Action/Push"
@onready var _player_stun: PlayerStun = $"../../Action/Stun"
@onready var _player_block: PlayerBlock = $"../../Action/Block"
@onready var _player_attack: PlayerAttack = $"../../Action/Attack"
@onready var _player_input: PlayerInput = $"../../Input"
@onready var _animation_player: AnimationPlayer = $"../AnimationPlayer"


func _process(_delta: float) -> void:
	if _player.input_direction.length() > 0.1:
		_model.look_at(_model.global_position + _player.input_direction, Vector3.UP, true)
		_shield.look_at(_shield.global_position + _player.input_direction, Vector3.UP, true)
	
	# TODO: Interpolate
	
	if _slide_component.is_sliding:
		var floor_normal: Vector3 = _player.get_floor_normal()
		_model.look_at(_model.global_position + _player.horizontal_velocity, floor_normal, true)
		_animation_player.play("Slide")
	elif not _player.is_on_floor():
		if _player.vertical_velocity.y > 0:
			_animation_player.play("Jump")
		else:
			_animation_player.play("Fall")
	elif _player_push.is_pushing:
		_animation_player.play("Poke")
	elif _player_stun.is_stunning:
		_animation_player.play("Stun")
	elif _player_block.is_blocking:
		_animation_player.play("Block")
	elif _player_attack.is_attacking:
		_animation_player.play("Hit")
	elif _player.horizontal_velocity.length() < 1:
		_animation_player.play("Idle")
	elif _player_input.running:
		_animation_player.play("Run")
	else:
		_animation_player.play("Walk")

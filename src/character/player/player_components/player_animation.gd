extends Node

@export var player: Player
@export var model: Node3D
@export var slide_component: Node

@onready var player_push: PlayerPush = $"../../Action/Push"

var is_stunning: bool = false

func _on_player_input_stun_pressed():
	is_stunning = true
	await get_tree().create_timer(0.8).timeout
	is_stunning = false
	


func _process(_delta: float) -> void:
	if player.horizontal_direction.length() > 0.1:
		model.look_at(model.global_position + player.horizontal_direction, Vector3.UP, true)
	var anim: AnimationPlayer = model.get_child(1)	# TODO: Get this in propper way
	
	# TODO: Interpolate
	
	# TODO: Attack and poke animations
	if slide_component.is_sliding:
		var floor_normal = player.get_floor_normal()
		model.look_at(model.global_position + player.horizontal_velocity, floor_normal, true)
		anim.play("Slide")
	elif not player.is_on_floor():
		if player.vertical_velocity.y > 0:
			anim.play("Jump")
		else:
			anim.play("Fall")
	elif player_push.is_pushing:
		anim.play("Poke")
	elif is_stunning:
		anim.play("Stun")
	elif player.horizontal_velocity.length() < 1:
		anim.play("Idle")
	elif not $"../../Input".running:
		anim.play("Walk")
	else:
		anim.play("Run")
	

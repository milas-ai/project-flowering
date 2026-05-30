extends Node

@export var player: Player
@export var model: Node3D


func _process(_delta: float) -> void:
	if (player.horizontal_direction.length() != 0):
		model.look_at(player.position + player.horizontal_direction, Vector3.UP, true)
	var anim: AnimationPlayer = model.get_child(1)	# Get this in propper way
	
	# Interpolate
	if (player.horizontal_velocity.length() < 1):
		anim.play("Idle")
	elif not $"../../Input".running:
		anim.play("Walk")
	else:
		anim.play("Run")

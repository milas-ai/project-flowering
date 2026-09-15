extends State
class_name StateIdle

func _enter() -> void:
	if body.animation_player.get_assigned_animation() != "idle":
		body.animation_player.play("idle")

func _update(_delta: float) -> void:
	if body.player_on_far_sight and not body.steady:
		state_machine.transition_to("StateChase")
		return
	
	if body.player_on_near_sight:
		body.horizontal_velocity = Math.lerpfd(body.horizontal_velocity, Vector3.ZERO, body.friction, _delta)
		state_machine.transition_to("StateAttack")

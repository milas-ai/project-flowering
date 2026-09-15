extends State
class_name StateIdle

func _enter() -> void:
	# print("Entering StateIdle")
	pass

func _update(_delta: float) -> void:
	if body.player_on_far_sight and not body.steady:
		state_machine.transition_to("StateChase")
		return
	
	if body.player_on_near_sight:
		body.horizontal_velocity = Math.lerpfd(body.horizontal_velocity, Vector3.ZERO, body.friction, _delta)
		state_machine.transition_to("StateAttack")

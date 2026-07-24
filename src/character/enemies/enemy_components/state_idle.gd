extends State

class_name StateIdle

func _enter() -> void:
	print("Entering StateIdle")

func _update(_delta: float) -> void:
	if body.player_on_far_sight:
		state_machine.transition_to("StateChase")

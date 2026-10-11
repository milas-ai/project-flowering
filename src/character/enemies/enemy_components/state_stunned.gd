extends State
class_name StateStunned

@export var stun_duration: float = 5.0

func _enter() -> void:
	body.horizontal_velocity = Vector3.ZERO
	body.animation_player.stop()

	get_tree().create_timer(stun_duration).timeout.connect(func(): state_machine.transition_to("StateIdle"))

func _update(_delta: float) -> void:
	body.horizontal_velocity = Vector3.ZERO

func _exit() -> void:
	state_machine.transition_to("StateIdle")
	

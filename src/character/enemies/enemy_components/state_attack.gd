extends State
class_name StateAttack

var on_cooldown: bool = false


func _enter() -> void:
	print("Entering StateAttack")

func _update(_delta: float) -> void:
	if not body.player_on_near_sight:
		state_machine.transition_to("StateChase")

	if not on_cooldown:
		on_cooldown = true
		body.attack_player()
		get_tree().create_timer(body.attack_cooldown).timeout.connect(func(): on_cooldown = false)

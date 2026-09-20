extends State
class_name StateAttack


var on_cooldown: bool = false


func _enter() -> void:
	body.animation_player.play("attack")

func _update(_delta: float) -> void:
	if not on_cooldown:
		if not body.player_on_near_sight:
				state_machine.transition_to("StateChase" if not body.steady else "StateIdle")
				return
		on_cooldown = true
		body.attack_player()
		get_tree().create_timer(body.animation_player.current_animation_length + body.attack_cooldown).timeout.connect(func(): on_cooldown = false)

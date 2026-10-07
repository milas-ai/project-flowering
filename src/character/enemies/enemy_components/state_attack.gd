class_name StateAttack
extends State


var _on_cooldown: bool = false


func enter() -> void:
	body.animation_player.play("attack")


func update(_delta: float) -> void:
	if not _on_cooldown:
		if not body.player_on_near_sight:
				state_machine.transition_to("StateChase" if not body.steady else "StateIdle")
				return
		_on_cooldown = true
		body.attack_player()
		get_tree().create_timer(body.animation_player.current_animation_length + body.attack_cooldown).timeout.connect(func(): _on_cooldown = false)


func exit() -> void:
	pass

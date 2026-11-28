class_name StateBossAttack
extends State


var _on_cooldown: bool = false


func enter() -> void:
	body.animation_player.play("fire")


func update(_delta: float) -> void:
	if not _on_cooldown:
		_on_cooldown = true
		body.attack_player()
		get_tree().create_timer(
				body.animation_player.current_animation_length + BaseStat.BOSS.SHOT_COOLDOWN
		).timeout.connect(
				func(): _on_cooldown = false)


func exit() -> void:
	_on_cooldown = false

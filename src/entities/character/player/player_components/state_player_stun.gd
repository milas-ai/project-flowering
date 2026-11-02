class_name StatePlayerStun
extends State


@onready var _stun_area := body.get_node("StunArea")


func enter() -> void:
	body.animation_player.play("Stun")
	for entity in _stun_area.get_overlapping_bodies():
		if entity.collision_layer & LayerBitmask.ENEMY:
			entity.apply_stun()
	
	get_tree().create_timer(0.8).timeout.connect(
			func(): state_machine.transition_to("StatePlayerIdle")
	)

func update(delta: float) -> void:
	body.process_horizontal_movement(delta, Vector3.ZERO, BaseStat.PLAYER.SPEED)


func exit() -> void:
		pass

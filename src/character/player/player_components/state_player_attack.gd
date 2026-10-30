class_name StatePlayerAttack
extends State


@onready var _hurtbox_component := body.get_node("CharacterModel/HurtboxComponent3D")


func enter() -> void:
	body.animation_player.play("Hit")
	_hurtbox_component.process_mode = Node.PROCESS_MODE_INHERIT
	
	get_tree().create_timer(
			body.animation_player.current_animation_length
	).timeout.connect(
			func(): state_machine.transition_to("StatePlayerIdle")
	)


func update(delta: float) -> void:
	body.process_horizontal_movement(delta, Vector3.ZERO, BaseStat.PLAYER.SPEED)


func exit() -> void:
	_hurtbox_component.process_mode = Node.PROCESS_MODE_DISABLED

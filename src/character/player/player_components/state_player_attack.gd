class_name StatePlayerAttack
extends State


@onready var _hurtbox_component := $"../../HurtboxComponent3D"


func enter() -> void:
	body.animation_player.play("attack")
	_hurtbox_component.process_mode = Node.PROCESS_MODE_INHERIT
	
	get_tree().create_timer(
			body.animation_player.current_animation_length
	).timeout.connect(
			func(): state_machine.transition_to("StatePlayerIdle")
	)


func update(_delta: float) -> void:
	pass


func exit() -> void:
	_hurtbox_component.process_mode = Node.PROCESS_MODE_DISABLED

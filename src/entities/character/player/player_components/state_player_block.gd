class_name StatePlayerBlock
extends State


@onready var _shield := body.get_node("CharacterModel/ShieldRigidBody3D")


func enter() -> void:
	body.animation_player.play("Block")
	_shield.process_mode = Node.PROCESS_MODE_INHERIT


func update(delta: float) -> void:
	body.process_horizontal_movement(delta, Vector3.ZERO, BaseStat.PLAYER.SPEED)
	body.process_rotation(false)


func exit() -> void:
	body.animation_player.play_backwards("Block")
	_shield.process_mode = Node.PROCESS_MODE_DISABLED

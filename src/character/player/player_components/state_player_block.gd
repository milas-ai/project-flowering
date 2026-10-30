class_name StatePlayerBlock
extends State


@onready var _shield := body.get_node("ShieldRigidBody3D")


func enter() -> void:
	body.animation_player.play("Block")
	_shield.process_mode = Node.PROCESS_MODE_INHERIT


func update(_delta: float) -> void:
	pass


func exit() -> void:
	body.animation_player.play_backwards("Block")
	_shield.process_mode = Node.PROCESS_MODE_DISABLED

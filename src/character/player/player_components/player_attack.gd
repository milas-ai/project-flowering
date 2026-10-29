class_name PlayerAttack
extends Node


var is_attacking: bool = false

@onready var hurtbox_component := $"../../HurtboxComponent3D"


func _ready() -> void:
	hurtbox_component.damage = BaseStat.PLAYER.DAMAGE


func _on_player_input_attack_pressed():
	if not is_attacking:
		is_attacking = true
		hurtbox_component.process_mode = Node.PROCESS_MODE_INHERIT
		get_tree().create_timer(0.45).timeout.connect(_release_hurtbox)


func _release_hurtbox():
	is_attacking = false
	hurtbox_component.process_mode = Node.PROCESS_MODE_DISABLED

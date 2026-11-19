class_name NPC
extends StaticBody3D


var _wave_on_cooldown: bool = false

@onready var _model: Node3D = $Model
@onready var _animation_player: AnimationPlayer = $Model/AnimationPlayer


func _ready() -> void:
	_animation_player.play("Idle")


func _on_wave_area_body_entered(player: Node) -> void:
	if not _wave_on_cooldown:
		_wave_on_cooldown = true
		_model.rotation.y = player.position.x - _model.position.x
		_animation_player.play("Wave")
		_animation_player.queue("Idle")
		await get_tree().create_timer(5.0).timeout
		_wave_on_cooldown = false

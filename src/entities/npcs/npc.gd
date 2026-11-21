class_name NPC
extends StaticBody3D


const WAVE_COOLDOWN: float = 5.0

var _wave_on_cooldown: bool = false
var _player: Player = null

@onready var _model: Node3D = $Model
@onready var _animation_player: AnimationPlayer = $Model/AnimationPlayer


func _ready() -> void:
	_animation_player.play("Idle")


func _on_wave_area_body_entered(player: Node) -> void:
	if not _wave_on_cooldown:
		_wave_on_cooldown = true
		_model.look_at(player.global_transform.origin, Vector3.UP, true)
		_model.rotation.x = 0.0
		_animation_player.play("Wave")
		_animation_player.queue("Idle")
		get_tree().create_timer(WAVE_COOLDOWN).timeout.connect(
				func(): _wave_on_cooldown = false)


func _on_dialog_area_body_entered(body: Node3D) -> void:
	if _player == null:
		_player = body as Player


func _on_dialog_area_interacted() -> void:
	_model.look_at(_player.global_transform.origin, Vector3.UP, true)
	_model.rotation.x = 0.0

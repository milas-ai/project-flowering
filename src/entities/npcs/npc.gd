class_name NPC
extends StaticBody3D


signal dialog_finished(npc_name: String)

const WAVE_COOLDOWN: float = 5.0

@export var dialog_text: String

var _wave_on_cooldown: bool = false

@onready var _model: Node3D = $Model
@onready var _animation_player: AnimationPlayer = $Model/AnimationPlayer
@onready var _main_game: MainGame = $/root/MainGame


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


func _on_dialog_area_interacted() -> void:
	_model.look_at(_main_game.player.global_transform.origin, Vector3.UP, true)
	_model.rotation.x = 0.0
	_main_game.hud_root.display_dialog(tr(dialog_text))
	emit_signal("dialog_finished", name)

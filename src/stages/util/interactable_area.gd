class_name InteractableArea
extends Area3D


signal interacted

var _is_player_inside: bool = false
var _enabled: bool = true


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _input(event: InputEvent) -> void:
	if _enabled and _is_player_inside and event.is_action_pressed("interact"):
		get_viewport().set_input_as_handled()
		interacted.emit()


func disable() -> void:
	_enabled = false


func _on_body_entered(_body: Node3D) -> void:
	_is_player_inside = true


func _on_body_exited(_body: Node3D) -> void:
	_is_player_inside = false

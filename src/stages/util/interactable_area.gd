class_name InteractableArea
extends Area3D


signal interacted

var _is_player_inside: bool = false
var _enabled: bool = true

@onready var _interaction_popup: Sprite3D = load(SceneUID.GUI.INTERACTION_POPUP).instantiate()


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	_interaction_popup.position.y = 1.5
	_interaction_popup.hide()
	add_child(_interaction_popup)


func _input(event: InputEvent) -> void:
	if _enabled and _is_player_inside and event.is_action_pressed("interact"):
		get_viewport().set_input_as_handled()
		interacted.emit()


func disable() -> void:
	_enabled = false
	_interaction_popup.hide()


func _on_body_entered(_body: Node3D) -> void:
	if _enabled:
		_is_player_inside = true
		_interaction_popup.show()


func _on_body_exited(_body: Node3D) -> void:
	if _enabled:
		_is_player_inside = false
		_interaction_popup.hide()

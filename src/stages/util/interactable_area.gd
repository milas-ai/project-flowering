class_name InteractableArea
extends Area3D


signal interacted

var _is_player_inside: bool = false

@onready var _interaction_popup: Sprite3D = load(SceneUID.GUI.INTERACTION_POPUP).instantiate()
@onready var _main_camera: Camera3D = $/root/MainGame.player.get_node("%MainCamera")
@onready var _unscaled_camera: Camera3D = $/root/MainGame.get_node("%UnscaledCamera")


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	_interaction_popup.position = global_transform.origin + Vector3(0, 1.5, 0)
	_interaction_popup.hide()
	_unscaled_camera.add_sibling(_interaction_popup)

	_interaction_popup.texture = ControllerManager.controller_layout.INTERACT
	ControllerManager.controller_layout_changed.connect(_on_controller_layout_changed)


func _process(_delta: float) -> void:
	if _is_player_inside:
		_unscaled_camera.global_transform = _main_camera.global_transform


func _input(event: InputEvent) -> void:
	if _is_player_inside and event.is_action_pressed("interact"):
		get_viewport().set_input_as_handled()
		interacted.emit()


func disable() -> void:
	_interaction_popup.hide()
	process_mode = PROCESS_MODE_DISABLED


func _on_body_entered(_body: Node3D) -> void:
	_is_player_inside = true
	_interaction_popup.show()


func _on_body_exited(_body: Node3D) -> void:
	_is_player_inside = false
	_interaction_popup.hide()


func _on_controller_layout_changed() -> void:
	_interaction_popup.texture = ControllerManager.controller_layout.INTERACT

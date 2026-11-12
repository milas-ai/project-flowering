@abstract
class_name BaseMenu
extends Control


@onready var _main_game: MainGame


func _ready() -> void:
	_main_game = $/root/MainGame as MainGame
	ControllerManager.controller_layout_changed.connect(_on_controller_layout_changed)


@abstract func focus_first_control() -> void


func _on_controller_layout_changed() -> void:
	if ControllerManager.controller_layout.type != ControllerManager.TYPE.KEYBOARD:
		focus_first_control()
		ControllerManager.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		get_viewport().gui_get_focus_owner().release_focus()
		ControllerManager.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
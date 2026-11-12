@abstract
class_name BaseMenu
extends Control


@onready var _main_game: MainGame
@onready var _parent_control: Node


func _ready() -> void:
	_main_game = $/root/MainGame as MainGame
	_parent_control = get_parent()
	ControllerManager.controller_layout_changed.connect(_on_controller_layout_changed)
	visibility_changed.connect(_on_visibility_changed)


@abstract func focus_first_control() -> void


func _on_controller_layout_changed() -> void:
	if is_visible_in_tree():
		if ControllerManager.controller_layout.type != ControllerManager.TYPE.KEYBOARD:
			focus_first_control()
			ControllerManager.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			var focus_owner: Control = get_viewport().gui_get_focus_owner() as Control
			if focus_owner:
				focus_owner.release_focus.call_deferred()
			ControllerManager.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_visibility_changed() -> void:
	if is_visible_in_tree():
		_on_controller_layout_changed()

class_name AnimatedCheckBox
extends CheckBox


var _tween: Tween = null


func _ready() -> void:
	offset_transform_enabled = true
	mouse_entered.connect(_on_button_mouse_entered)
	focus_entered.connect(_on_button_mouse_entered)
	mouse_exited.connect(_on_button_mouse_exited)
	focus_exited.connect(_on_button_mouse_exited)
	button_down.connect(_on_button_pressed)


func _on_button_mouse_entered() -> void:
	if _tween and _tween.is_valid():
		_tween.kill()
	
	_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	_tween.tween_property(self, "offset_transform_scale", Vector2(1.1, 1.1), 0.2)


func _on_button_mouse_exited() -> void:
	if _tween and _tween.is_valid():
		_tween.kill()

	_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	_tween.tween_property(self, "offset_transform_scale", Vector2.ONE, 0.2)


func _on_button_pressed() -> void:
	if _tween and _tween.is_valid():
		_tween.kill()
	_tween = create_tween().set_ease(Tween.EASE_OUT)

	_tween.tween_property(self, "offset_transform_scale", Vector2(1.15, 0.9), 0.2).set_trans(Tween.TRANS_QUAD)
	_tween.tween_property(self, "offset_transform_scale", Vector2.ONE, 0.3).set_trans(Tween.TRANS_BACK)

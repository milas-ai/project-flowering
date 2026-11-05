class_name DialogBox
extends MarginContainer


signal dialog_finished

const LETTER_DISPLAY_DELAY: float = 0.06
const SPACE_DISPLAY_DELAY: float = 0.08
const PUNCTUATION_DISPLAY_DELAY: float = 0.25
const OFF_SCREEN_OFFSET := Vector2(0, 500)

var _text: String
var _lines: Array
var _letter_index: int
var _line_index: int
var _line_finished: bool

@onready var _dialog_label: Label = %DialogLabel
@onready var _letter_timer: Timer = $LetterDisplayTimer


func _ready() -> void:
	offset_transform_position = OFF_SCREEN_OFFSET


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		get_viewport().set_input_as_handled()
		if _line_finished:
			_line_index += 1
			_display_line()
		else:
			_letter_timer.stop()
			_dialog_label.text = _text
			_line_finished = true


func display_dialog(dialog_text: String) -> void:
	_line_index = 0
	_lines = dialog_text.split("\n")

	show()
	var tween := create_tween()
	tween.tween_property(self, "offset_transform_position", Vector2.ZERO, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	tween.tween_callback(_display_line)


func _hide() -> void:
	var tween := create_tween()
	tween.tween_property(self, "offset_transform_position", OFF_SCREEN_OFFSET, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_callback(_finish_dialog)


func _display_line() -> void:
	if _line_index < _lines.size():
		_letter_index = 0
		_line_finished = false
		_dialog_label.text = ""
		_text = _lines[_line_index]
		_letter_timer.start(LETTER_DISPLAY_DELAY)
	else:
		_hide()


func _finish_dialog() -> void:
	hide()
	_dialog_label.text = ""
	dialog_finished.emit()


func _print_letter() -> void:
	_dialog_label.text += _text[_letter_index]
	_letter_index += 1
	if _letter_index < _text.length():
		match _text[_letter_index]:
			" ":
				_letter_timer.start(SPACE_DISPLAY_DELAY)
			".", ",", "!", "?":
				_letter_timer.start(PUNCTUATION_DISPLAY_DELAY)
			_:
				_letter_timer.start(LETTER_DISPLAY_DELAY)
	else:
		_line_finished = true


func _on_letter_display_timer_timeout() -> void:
	_print_letter()

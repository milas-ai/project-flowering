class_name DialogBox
extends MarginContainer


const LETTER_DISPLAY_DELAY: float = 0.06
const SPACE_DISPLAY_DELAY: float = 0.08
const PUNCTUATION_DISPLAY_DELAY: float = 0.25

var _text: String
var _lines: Array
var _letter_index: int
var _line_index: int
var _line_finished: bool
var _dialog_finished: bool = true

@onready var _dialog_label: Label = %DialogLabel
@onready var _letter_timer: Timer = $LetterDisplayTimer


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and not _dialog_finished and not get_tree().paused:
		print("DialogBox: Interact button pressed.")
		get_viewport().set_input_as_handled()
		if _line_finished:
			_line_index += 1
			_display_line()
		else:
			_letter_timer.stop()
			_dialog_label.text = _text
			_line_finished = true


func display_dialog(dialog_text: String) -> void:
	_show()
	_dialog_finished = false
	_line_index = 0
	_lines = dialog_text.split("\n")
	_display_line()


func _show() -> void:
	show()


func _hide() -> void:
	hide()


func _display_line() -> void:
	if _line_index < _lines.size():
		_letter_index = 0
		_line_finished = false
		_dialog_label.text = ""
		_text = _lines[_line_index]
		_print_letter()
	else:
		_finish_dialog()


func _finish_dialog() -> void:
	_dialog_finished = true
	_hide()


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

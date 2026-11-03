extends Node


signal controller_layout_changed()

enum TYPE {
	KEYBOARD,
	XBOX,
	PLAYSTATION,
	SWITCH,
}

var controller_layout : ControllerLayout = ControllerLayout.new(TYPE.KEYBOARD):
	set(value):
		if value.type != controller_layout.type:
			controller_layout = value
			controller_layout_changed.emit()
	
var _keyboard_controller_layout := ControllerLayout.new(TYPE.KEYBOARD)
var _xbox_controller_layout := ControllerLayout.new(TYPE.XBOX)
var _playstation_controller_layout := ControllerLayout.new(TYPE.PLAYSTATION)
var _switch_controller_layout := ControllerLayout.new(TYPE.SWITCH)


func _ready() -> void:
	Input.joy_connection_changed.connect(_update_joypad_type)
	_update_joypad_type()


func _input(event: InputEvent) -> void:
	if event is InputEventJoypadMotion or event is InputEventJoypadButton:
		if event is InputEventJoypadMotion and abs(event.axis_value) < 0.1:
			return
		_update_joypad_type()
	
	elif event is InputEventKey or event is InputEventMouseButton or event is InputEventMouseMotion:
		controller_layout = _keyboard_controller_layout


func _update_joypad_type() -> void:
	var joypads := Input.get_connected_joypads()
	if joypads.size() > 0:
		var joypad_name := Input.get_joy_name(joypads[0]).to_lower()
		
		if joypad_name.find("xbox") != -1:
			controller_layout = _xbox_controller_layout
		elif joypad_name.find("playstation") != -1 or joypad_name.find("ps4") != -1 or joypad_name.find("ps5") != -1:
			controller_layout = _playstation_controller_layout
		elif joypad_name.find("switch") != -1:
			controller_layout = _switch_controller_layout
		else:
			controller_layout = _xbox_controller_layout
	else:
		controller_layout = _keyboard_controller_layout


class ControllerLayout:
	var INTERACT: Texture2D
	var ATTACK: Texture2D
	var BLOCK: Texture2D
	var SLIDE: Texture2D
	var STUN: Texture2D
	var PUSH: Texture2D
	var type: int
	
	func _init(controller_type: int) -> void:
		match controller_type:
			TYPE.KEYBOARD:
				type = TYPE.KEYBOARD
				INTERACT = load(AssetUID.TEXTURE.UI.PROMPT.KEYBOARD.E)
				# ATTACK = load(AssetUID.TEXTURE.UI.PROMPT.MOUSE.LEFT)
				# BLOCK = load(AssetUID.TEXTURE.UI.PROMPT.MOUSE.RIGHT)
				# SLIDE = load(AssetUID.TEXTURE.UI.PROMPT.KEYBOARD.CTRL)
				# STUN = load(AssetUID.TEXTURE.UI.PROMPT.KEYBOARD.C)
				PUSH = load(AssetUID.TEXTURE.UI.PROMPT.KEYBOARD.E)
			TYPE.XBOX:
				type = TYPE.XBOX
				INTERACT = load(AssetUID.TEXTURE.UI.PROMPT.XBOX.X)
				ATTACK = load(AssetUID.TEXTURE.UI.PROMPT.XBOX.X)
				# BLOCK = load(AssetUID.TEXTURE.UI.PROMPT.XBOX.LT)
				# SLIDE = load(AssetUID.TEXTURE.UI.PROMPT.XBOX.LB)
				STUN = load(AssetUID.TEXTURE.UI.PROMPT.XBOX.Y)
				PUSH = load(AssetUID.TEXTURE.UI.PROMPT.XBOX.B)
			TYPE.PLAYSTATION:
				type = TYPE.PLAYSTATION
				INTERACT = load(AssetUID.TEXTURE.UI.PROMPT.PLAYSTATION.SQUARE)
				ATTACK = load(AssetUID.TEXTURE.UI.PROMPT.PLAYSTATION.SQUARE)
				# BLOCK = load(AssetUID.TEXTURE.UI.PROMPT.PLAYSTATION.L2)
				# SLIDE = load(AssetUID.TEXTURE.UI.PROMPT.PLAYSTATION.L1)
				STUN = load(AssetUID.TEXTURE.UI.PROMPT.PLAYSTATION.TRIANGLE)
				PUSH = load(AssetUID.TEXTURE.UI.PROMPT.PLAYSTATION.CIRCLE)
			TYPE.SWITCH:
				type = TYPE.SWITCH
				INTERACT = load(AssetUID.TEXTURE.UI.PROMPT.SWITCH.Y)
				ATTACK = load(AssetUID.TEXTURE.UI.PROMPT.SWITCH.Y)
				# BLOCK = load(AssetUID.TEXTURE.UI.PROMPT.SWITCH.ZL)
				# SLIDE = load(AssetUID.TEXTURE.UI.PROMPT.SWITCH.L)
				STUN = load(AssetUID.TEXTURE.UI.PROMPT.SWITCH.X)
				PUSH = load(AssetUID.TEXTURE.UI.PROMPT.SWITCH.A)

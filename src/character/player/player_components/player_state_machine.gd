extends StateMachine


const STATES_TO_ATTACK = ["StatePlayerIdle", "StatePlayerMove", "StatePlayerJump", "StatePlayerFall", "StatePlayerBlock", "StatePlayerSlide"]
const STATES_TO_BLOCK = ["StatePlayerIdle", "StatePlayerMove", "StatePlayerJump", "StatePlayerFall"]
const STATES_TO_STUN = ["StatePlayerIdle", "StatePlayerMove", "StatePlayerJump", "StatePlayerFall", "StatePlayerBlock"]
const STATES_TO_PUSH = ["StatePlayerIdle", "StatePlayerMove", "StatePlayerJump", "StatePlayerFall", "StatePlayerBlock"]
const STATES_TO_JUMP = ["StatePlayerIdle", "StatePlayerMove", "StatePlayerBlock", "StatePlayerSlide"]
const STATES_TO_SLIDE = ["StatePlayerIdle", "StatePlayerMove", "StatePlayerBlock", "StatePlayerFall"]

var sliding_pressed: bool = false
var running_pressed: bool = false


func _process(_delta: float) -> void:
	if sliding_pressed:
		if _state.name in STATES_TO_SLIDE:
			if body.is_on_floor() and body.get_floor_normal().y < 0.98:
				transition_to("StatePlayerSlide")


func _on_input_attack_pressed():
	if _state.name in STATES_TO_ATTACK:
		transition_to("StatePlayerAttack")


func _on_input_block_pressed():
	if _state.name in STATES_TO_BLOCK:
		transition_to("StatePlayerBlock")


func _on_input_block_released():
	if _state.name == "StatePlayerBlock":
		transition_to("StatePlayerIdle")


func _on_input_stun_pressed():
	if _state.name in STATES_TO_STUN:
		transition_to("StatePlayerStun")


func _on_input_push_pressed():
	if _state.name in STATES_TO_PUSH:
		transition_to("StatePlayerPush")


func _on_input_jump_pressed():
	if _state.name == "StatePlayerSlide" or (body.is_on_floor() and _state.name in STATES_TO_JUMP):
		transition_to("StatePlayerJump")


func _on_input_slide_pressed():
	sliding_pressed = true


func _on_input_slide_released():
	if _state.name == "StatePlayerSlide":
		transition_to("StatePlayerIdle")
	sliding_pressed = false


func _on_input_run_pressed():
	running_pressed = true


func _on_input_run_released():
	running_pressed = false

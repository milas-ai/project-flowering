extends StateMachine


@onready var _move_state := $StatePlayerMove


func _on_input_attack_pressed():
	if _state.name not in ["StatePlayerStun", "StatePlayerPush"]:
		transition_to("StatePlayerAttack")


func _on_input_block_pressed():
	if _state.name not in ["StatePlayerAttack", "StatePlayerStun", "StatePlayerPush", "StatePlayerSlide"]:
		transition_to("StatePlayerBlock")


func _on_input_block_released():
	if _state.name == "StatePlayerBlock":
		transition_to("StatePlayerIdle")


func _on_input_stun_pressed():
	if _state.name not in ["StatePlayerAttack", "StatePlayerPush", "StatePlayerSlide"]:
		transition_to("StatePlayerStun")


func _on_input_push_pressed():
	if _state.name not in ["StatePlayerAttack", "StatePlayerStun", "StatePlayerSlide"]:
		transition_to("StatePlayerPush")


func _on_input_jump_pressed():
	if body.is_on_floor() and _state.name in ["StatePlayerIdle", "StatePlayerMove", "StatePlayerBlock"]:
		transition_to("StatePlayerJump")


func _on_input_slide_pressed():
	if _state.name not in ["StatePlayerAttack", "StatePlayerStun", "StatePlayerPush"]:
		if body.is_on_floor() and body.get_floor_normal().y < 0.98:
			transition_to("StatePlayerSlide")


func _on_input_slide_released():
	if _state.name == "StatePlayerSlide":
		transition_to("StatePlayerIdle")


func _on_input_run_pressed():
	_move_state.start_running()


func _on_input_run_released():
	_move_state.stop_running()

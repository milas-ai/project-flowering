extends StateMachine


func _process(_delta: float) -> void:
	pass


func _on_input_attack_pressed():
	pass


func _on_input_block_pressed():
	pass


func _on_input_block_released():
	pass


func _on_input_stun_pressed():
	pass


func _on_input_push_pressed():
	pass


func _on_input_jump_pressed():
	if body.is_on_floor():
		transition_to("StatePlayerJump")


func _on_input_slide_pressed():
	if body.is_on_floor() and body.get_floor_normal().y < 0.98:
		transition_to("StatePlayerSlide")


func _on_input_slide_released():
	if _state.name == "StatePlayerSlide":
		transition_to("StatePlayerIdle")


func _on_input_run_pressed():
	pass


func _on_input_run_released():
	pass

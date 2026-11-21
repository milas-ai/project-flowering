extends BaseStage


var _exit_blocked: bool = true


func _on_respawn_area_body_entered(body: Node3D) -> void:
	if body.collision_layer & LayerBitmask.PLAYER:
		_main_game.player.horizontal_velocity = Vector3.ZERO
		_main_game.player.vertical_velocity = Vector3.ZERO
		_main_game.player.global_position = current_checkpoint.global_position
		_main_game.player.state_machine.reset_pressed_inputs()

	elif body.collision_layer & LayerBitmask.ENEMY:
		body.queue_free()


func _on_exit_area_interacted() -> void:
	if _exit_blocked:
		_main_game.hud_root.display_dialog(tr("VILLAGE_BLOCKED_EXIT_DIALOG"))
	else:
		_main_game.transition_to_stage(SceneUID.STAGES.MOUNTAIN)


func _on_npc_dialog_finished(npc_name: String) -> void:
	if npc_name == "Mayor":
		_exit_blocked = false

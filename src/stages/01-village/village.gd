extends BaseStage


var _exit_blocked: bool = true


func _on_exit_area_interacted() -> void:
	if _exit_blocked:
		_main_game.hud_root.display_dialog(tr("VILLAGE_BLOCKED_EXIT_DIALOG"))
	else:
		_main_game.transition_to_stage(SceneUID.STAGES.MOUNTAIN)


func _on_npc_dialog_finished(npc_name: String) -> void:
	if npc_name == "Mayor":
		_exit_blocked = false

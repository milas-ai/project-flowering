extends BaseStage


func _on_display_credits_area_interacted() -> void:
	_main_game.hud_root.display_dialog(tr("EPILOGUE_CREDITS"))

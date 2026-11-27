extends BaseStage


func _on_get_item_area_interacted() -> void:
	_main_game.player.items = BaseStat.PLAYER.ITEMS.SCISSORS
	$InteractableAreas/GetItemArea.disable()
	$InteractableAreas/GetItemArea/Item.queue_free()


func _on_display_scissors_tutorial_area_interacted() -> void:
	_main_game.hud_root.display_dialog(tr("SCISSORS_TUTORIAL").format({
			"push_key" : "[img=0x100]%s[/img]" % ControllerManager.controller_layout.PUSH.resource_path,
			"attack_key" : "[img=0x100]%s[/img]" % ControllerManager.controller_layout.ATTACK.resource_path
	}))

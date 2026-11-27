extends BaseStage


func _on_get_item_area_interacted() -> void:
	_main_game.player.items = BaseStat.PLAYER.ITEMS.FIREFLY
	$InteractableAreas/GetItemArea.disable()
	$InteractableAreas/GetItemArea/Item.queue_free()

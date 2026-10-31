extends BaseStage


func _on_respawn_area_3d_body_entered(body: Node3D) -> void:
	if body.collision_layer & LayerBitmask.PLAYER:
		_main_game.player.take_damage(1)
		_main_game.player.horizontal_velocity = Vector3.ZERO
		_main_game.player.vertical_velocity = Vector3.ZERO
		_main_game.player.global_position = current_checkpoint.global_position

	elif body.collision_layer & LayerBitmask.ENEMY:
		body.queue_free()


func _on_get_item_area_interacted() -> void:
	_main_game.set_player_items(BaseStat.PLAYER.ITEMS.BOTTLE_CAP)
	$GetItemArea.disable()

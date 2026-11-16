extends BaseStage


func _on_respawn_area_body_entered(body: Node3D) -> void:
	if body.collision_layer & LayerBitmask.PLAYER:
		_main_game.player.horizontal_velocity = Vector3.ZERO
		_main_game.player.vertical_velocity = Vector3.ZERO
		_main_game.player.global_position = current_checkpoint.global_position
		_main_game.player.state_machine.reset_pressed_inputs()

	elif body.collision_layer & LayerBitmask.ENEMY:
		body.queue_free()

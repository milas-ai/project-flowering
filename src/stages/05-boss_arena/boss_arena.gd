extends BaseStage


func _ready() -> void:
	super._ready()
	_main_game.player.rotation.y = PI


func _on_door_closing_area_body_entered(_body: Node3D) -> void:
	call_deferred("_close_door")


func _close_door() -> void:
	%DoorClosingArea.process_mode = Node3D.PROCESS_MODE_DISABLED
	%DoorCollision.process_mode = Node3D.PROCESS_MODE_INHERIT
	%WebEntrance.show()
	%WebEntrance2.show()
	%WebEntrance3.show()

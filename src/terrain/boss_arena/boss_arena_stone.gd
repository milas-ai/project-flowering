class_name BossArenaStone
extends PushableProp


func explode() -> void:
	var pieces: Node3D = $BreakableStonePieces
	self.collision_layer = 0
	$Model.hide()
	pieces.show()
	pieces.process_mode = Node3D.PROCESS_MODE_INHERIT
	pieces.explode(3.0)
	get_tree().create_timer(6.0).connect(
			"timeout", Callable(self, "queue_free"))

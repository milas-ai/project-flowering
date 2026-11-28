extends Node3D


func explode(intensity: float) -> void:
	for piece: RigidBody3D in self.get_children():
		piece.apply_impulse(piece.get_child(0).position * intensity, self.global_position)
		get_tree().create_timer(5.0).timeout.connect(_shrink_and_free.bind(piece))


func _shrink_and_free(piece: RigidBody3D) -> void:
	var tween := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(piece, "scale", Vector3(0.01, 0.01, 0.01), 0.5)
	await tween.finished
	queue_free()

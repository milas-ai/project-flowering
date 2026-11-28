class_name StateShootingPhase
extends State


func enter() -> void:
	var hole_marker = body.hole_markers.pick_random()
	body.boss.process_mode = Node3D.PROCESS_MODE_INHERIT
	body.boss.position = hole_marker.global_position
	body.boss.rotation = hole_marker.global_rotation
	body.boss.animation_player.play("RESET")
	await body.boss.animation_player.animation_finished
	body.boss.show()
	body.boss.state_machine.transition_to("StateBossIdle")


func update(_delta: float) -> void:
	pass


func exit() -> void:
	body.boss.hide()
	body.boss.process_mode = Node3D.PROCESS_MODE_DISABLED

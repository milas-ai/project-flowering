extends Node3D


func _ready() -> void:
	$AnimationPlayer.play("turntable")
	# Set the camera size based on the turntable_camera_size property of the sibling BaseStage node
	$CameraPivot/Camera3D.size = get_parent().get_child(0).turntable_camera_size

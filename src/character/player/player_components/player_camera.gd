class_name PlayerCamera
extends Node3D


var _camera_rotation: float = deg_to_rad(45)


func _process(_delta: float) -> void:
	# Handle camera rotation
	if is_equal_approx(_camera_rotation, rotation.y):
		if Input.is_action_pressed("ui_left"):
			_camera_rotation -= deg_to_rad(90)
		elif Input.is_action_pressed("ui_right"):
			_camera_rotation += deg_to_rad(90)
	else:	
		rotation.y = lerp_angle(rotation.y, _camera_rotation, 0.1)

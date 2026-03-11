extends Node3D
class_name PlayerCamera

var camera_rotation: float = deg_to_rad(45)


func _process(delta: float) -> void:
	# Handle camera rotation
	if is_equal_approx(camera_rotation, rotation.y):
		if Input.is_action_pressed("ui_left"):
			camera_rotation -= deg_to_rad(90)
		elif Input.is_action_pressed("ui_right"):
			camera_rotation += deg_to_rad(90)
	else:	
		rotation.y = lerp_angle(rotation.y, camera_rotation, 0.1)

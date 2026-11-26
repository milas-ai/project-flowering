extends StaticBody3D


func _ready() -> void:
	visible = false
	set_collision_layer(get_collision_layer() + LayerBitmask.LIGHTABLE)

func light_up(_instant: bool) -> void:
	visible = true

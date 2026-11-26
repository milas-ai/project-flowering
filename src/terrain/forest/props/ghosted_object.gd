extends StaticBody3D


func _ready() -> void:
	for child: Node3D in get_children():
		child.visible = false
	set_collision_layer(get_collision_layer() + LayerBitmask.LIGHTABLE)

func light_up(_instant: bool) -> void:
	var children: Array[Node] = get_children()
	children.shuffle()
	for idx in range(children.size()):
		await get_tree().create_timer(.2).timeout
		children[idx].visible = true

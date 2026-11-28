extends StaticBody3D

@export var fog_color: Color = Color(0.18, 0.137, 0.176, 1.0)

var fog_volume: FogVolume


func _ready() -> void:
	for child: Node3D in get_children():
		if child is FogVolume: continue
		child.visible = false
	set_collision_layer(get_collision_layer() + LayerBitmask.LIGHTABLE)
	create_fog_volume()

func create_fog_volume() -> void:
	var collision_shape: CollisionShape3D = find_children("*", "CollisionShape3D", false, false)[0]
	var fog_mat := FogMaterial.new()
	fog_volume = FogVolume.new()
	fog_mat.emission = fog_color
	fog_volume.material = fog_mat
	self.add_child(fog_volume)
	fog_volume.size = collision_shape.shape.size
	fog_volume.position = collision_shape.position

func light_up(_instant: bool) -> void:
	var children: Array[Node] = get_children()
	children.shuffle()
	for idx in range(children.size()):
		children[idx].visible = true
	var tween := get_tree().create_tween()
	tween.tween_property(fog_volume.material, "density", 0, 1)

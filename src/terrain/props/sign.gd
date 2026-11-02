@tool
extends Node3D


@export_enum(
		"Text",
		"Up Arrow",
		"Down Arrow",
		"Left Arrow",
		"Right Arrow",
		"Up Left Arrow",
		"Up Right Arrow",
		"Down Left Arrow",
		"Down Right Arrow",
		"Skull",
) var paint: int = 0:
		set(value):
			paint = value
			_change_texture()


func _ready():
	_change_texture()


func _change_texture():
	var mesh_instance: MeshInstance3D = get_child(0)
	var surface_material: Material = mesh_instance.mesh.surface_get_material(0)
	surface_material = surface_material.duplicate()
	
	var texture: Texture2D
	match paint:
		0: texture = load(AssetUID.TEXTURE.TERRAIN.SIGN.TEXT)
		1: texture = load(AssetUID.TEXTURE.TERRAIN.SIGN.ARROW.UP)
		2: texture = load(AssetUID.TEXTURE.TERRAIN.SIGN.ARROW.DOWN)
		3: texture = load(AssetUID.TEXTURE.TERRAIN.SIGN.ARROW.LEFT)
		4: texture = load(AssetUID.TEXTURE.TERRAIN.SIGN.ARROW.RIGHT)
		5: texture = load(AssetUID.TEXTURE.TERRAIN.SIGN.ARROW.UP_LEFT)
		6: texture = load(AssetUID.TEXTURE.TERRAIN.SIGN.ARROW.UP_RIGHT)
		7: texture = load(AssetUID.TEXTURE.TERRAIN.SIGN.ARROW.DOWN_LEFT)
		8: texture = load(AssetUID.TEXTURE.TERRAIN.SIGN.ARROW.DOWN_RIGHT)
		9: texture = load(AssetUID.TEXTURE.TERRAIN.SIGN.SKULL)

	surface_material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	surface_material.albedo_texture = texture
	mesh_instance.material_override = surface_material

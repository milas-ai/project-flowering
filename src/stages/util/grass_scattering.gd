@tool
extends Node


const GRASS_COUNT_FACTOR: float = 1

@export_range(0, 100) var grass_ammount: float = 100
@export var target_mesh: MeshInstance3D
@export var scatter: bool: # re-scatter grass on runtime
	set(_val):
		scatter_grass()

var multimesh_instance: MultiMeshInstance3D


func _ready() -> void:
	scatter_grass()


func scatter_grass() -> void:
	reset_multimesh_node()
	scatter_grass_in_multimesh_instance()


func reset_multimesh_node() -> void:
	for instance in get_children().filter(func(x): return x is MultiMeshInstance3D):
		instance.queue_free()
	multimesh_instance = MultiMeshInstance3D.new()
	add_child(multimesh_instance)
	multimesh_instance.owner = self
	multimesh_instance.name = "GrassMultimesh"


func scatter_grass_in_multimesh_instance() -> void:
	var mdt := MeshDataTool.new()
	mdt.create_from_surface(target_mesh.mesh, 0)
	var face_count: int = mdt.get_face_count()
	
	var grass_count: int = int(grass_ammount * face_count * GRASS_COUNT_FACTOR)
	var rng := RandomNumberGenerator.new()
	
	multimesh_instance.multimesh = MultiMesh.new()
	multimesh_instance.multimesh.mesh = load(AssetUID.MODEL.TERRAIN.GRASS)
	multimesh_instance.material_override = load(AssetUID.MATERIAL.TERRAIN.GRASS)
	multimesh_instance.multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh_instance.multimesh.instance_count = grass_count
	multimesh_instance.multimesh.visible_instance_count = grass_count
	
	for i in range(grass_count):
		var face_idx: int = rng.randi_range(0, face_count-1)
		var vertex_index_A: int = mdt.get_face_vertex(face_idx, 0)
		var vertex_index_B: int = mdt.get_face_vertex(face_idx, 1)
		var vertex_index_C: int = mdt.get_face_vertex(face_idx, 2)
		
		var p1: Vector3 = mdt.get_vertex(vertex_index_A)
		var p2: Vector3 = mdt.get_vertex(vertex_index_B)
		var p3: Vector3 = mdt.get_vertex(vertex_index_C)
		
		# Interpolate random position on triangle
		var weight_random1: float = rng.randf()
		var weight_random2: float = rng.randf()
		var weight1: float = min(weight_random1, weight_random2)
		var weight2: float = max(weight_random1, weight_random2)
		var p_random: Vector3 = p1 * weight1 + p2 * (weight2-weight1) + p3 * (1.0-weight2)
		
		var transform: Transform3D = Transform3D(Basis(), p_random)
		transform = transform. scaled_local(Vector3.ONE * rng.randf_range(.7,1.2))
		multimesh_instance.multimesh.set_instance_transform(i, transform)

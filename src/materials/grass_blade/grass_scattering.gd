@tool
extends Node

const GRASS_MATERIAL_DIR: String = "res://src/materials/grass_blade/grass_blade_mat.tres"
const GRASS_MODEL_DIR: String = "res://src/materials/grass_blade/grass_blade_model.res"
const GRASS_COUNT_FACTOR: float = 1

@export_range(0, 100) var grass_ammount: float = 100
@export var target_mesh: MeshInstance3D
## re-scatter grass on runtime
@export var scatter: bool:
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
	var mdt: MeshDataTool = MeshDataTool.new()
	mdt.create_from_surface(target_mesh.mesh, 0)
	var face_count = mdt.get_face_count()
	
	var grass_count: int = int(grass_ammount * face_count * GRASS_COUNT_FACTOR)
	var rng = RandomNumberGenerator.new()
	
	multimesh_instance.multimesh = MultiMesh.new()
	multimesh_instance.multimesh.mesh = load(GRASS_MODEL_DIR)
	multimesh_instance.material_override = load(GRASS_MATERIAL_DIR)
	multimesh_instance.multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh_instance.multimesh.instance_count = grass_count
	multimesh_instance.multimesh.visible_instance_count = grass_count
	
	#TODO: select random pos based on uv instead, so it doesent get squashed
	for i in range(grass_count):
		var face_idx = rng.randi_range(0, face_count-1)
		var vertex_index_A = mdt.get_face_vertex(face_idx, 0)
		var vertex_index_B = mdt.get_face_vertex(face_idx, 1)
		var vertex_index_C = mdt.get_face_vertex(face_idx, 2)
		
		var p1 = mdt.get_vertex(vertex_index_A)
		var p2 = mdt.get_vertex(vertex_index_B)
		var p3 = mdt.get_vertex(vertex_index_C)
		
		# Interpolate random position on triangle
		var weight_random1 = rng.randf()
		var weight_random2 = rng.randf()
		var weight1 = min(weight_random1, weight_random2)
		var weight2 = max(weight_random1, weight_random2)
		var p_random = p1 * weight1 + p2 * (weight2-weight1) + p3 * (1.0-weight2)
		
		var transform: Transform3D = Transform3D(Basis(), p_random)
		transform = transform. scaled_local(Vector3.ONE * rng.randf_range(.7,1.2))
		multimesh_instance.multimesh.set_instance_transform(i, transform)

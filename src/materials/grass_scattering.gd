@tool
extends Node


const GRASS_MATERIAL_DIR: String = "res://src/materials/grass_blade.tres"
const GRASS_COUNT_FACTOR: float = 1

@export var scatter: bool = false:
	set(_value):
		if Engine.is_editor_hint():
			scatter_grass()
@export var clear: bool = false:
	set(_value):
		if Engine.is_editor_hint():
			for _multimesh in get_children().filter(func(x): return x is MultiMeshInstance3D):
				_multimesh.queue_free()
@export_range(0, 10) var grass_ammount: float = 4

var multimesh: MultiMeshInstance3D
var target_mesh: MeshInstance3D


func scatter_grass() -> void:
	if set_target_mesh() == false: return
	reset_multimesh_node()
	scatter_grass_in_multimesh()

func set_target_mesh() -> bool:
	target_mesh = get_child(0)
	if target_mesh is not MeshInstance3D: return false
	return true

func reset_multimesh_node() -> void:
	# Delete old one
	for _multimesh in get_children().filter(func(x): return x is MultiMeshInstance3D):
		_multimesh.queue_free()
	# Create new instance
	multimesh = MultiMeshInstance3D.new()
	add_child(multimesh)
	multimesh.owner = self
	multimesh.name = "GrassMultimesh"

func scatter_grass_in_multimesh() -> void:
	var mdt: MeshDataTool = MeshDataTool.new()
	mdt.create_from_surface(target_mesh.mesh, 0)
	var face_count = mdt.get_face_count()
	
	var grass_count: int = int(grass_ammount * face_count * GRASS_COUNT_FACTOR)
	var rng = RandomNumberGenerator.new()
	
	for i in range(grass_count):
		var face_idx = rng.randi_range(0, face_count-1)
		var vertex_index_A = mdt.get_face_vertex(face_idx, 0)
		var vertex_index_B = mdt.get_face_vertex(face_idx, 1)
		var vertex_index_C = mdt.get_face_vertex(face_idx, 2)
		
		var p1 = mdt.get_vertex(vertex_index_A)
		var p2 = mdt.get_vertex(vertex_index_B)
		var p3 = mdt.get_vertex(vertex_index_C)
		
		var weight_random1 = rng.randf()
		var weight_random2 = rng.randf()
		var weight1 = min(weight_random1, weight_random2)
		var weight2 = max(weight_random1, weight_random2)
		var p_random = p1 * weight1 + p2 * (weight2-weight1) + p3 * (1.0-weight2)
		
		var face_normal = mdt.get_face_normal(face_idx)
		
		var mesh_instance = MeshInstance3D.new()
		mesh_instance.mesh = QuadMesh.new()
		mesh_instance.mesh.surface_set_material(0, load(GRASS_MATERIAL_DIR))
		mesh_instance.cast_shadow = false
		
		mesh_instance.mesh.size = Vector2(2, 2)
		mesh_instance.mesh.orientation = QuadMesh.FACE_Z
		# - normal because of FACE_Z
		mesh_instance.look_at_from_position(p_random, p_random - face_normal)
		mesh_instance.position = p_random + face_normal * rng.randf_range(.01, .02)
		
		multimesh.add_child(mesh_instance)
		mesh_instance.owner = self
		mesh_instance.name = "GrassBlade"

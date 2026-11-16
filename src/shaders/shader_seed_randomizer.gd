extends MeshInstance3D

@export var node: Node3D = null
@export var property_name: String
@export var min_value: float
@export var max_value: float


func _ready() -> void:
	if node == null: node = self
	node.set_instance_shader_parameter(property_name, randf_range(min_value, max_value))

class_name OclusionArea
extends Area3D


@export var nodes_to_enable: Array[Node3D]
@export var nodes_to_disable: Array[Node3D]


func _ready() -> void:
	body_entered.connect(_on_area_body_entered)
	body_exited.connect(_on_area_body_exited)


func _on_area_body_entered(_body: Node3D) -> void:
	for node in nodes_to_enable:
		node.visible = true
	
	for node in nodes_to_disable:
		node.visible = false


func _on_area_body_exited(_body: Node3D) -> void:
	for node in nodes_to_enable:
		node.visible = false
	
	for node in nodes_to_disable:
		node.visible = true

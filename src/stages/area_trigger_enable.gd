extends Area3D

@export var enable_nodes: Array[Node3D]
@export var disable_nodes: Array[Node3D]


func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered() -> void:
	for area in enable_nodes:
		area.process_mode = Node.PROCESS_MODE_INHERIT
		area.visible = true
	
	for area in disable_nodes:
		area.process_mode = Node.PROCESS_MODE_DISABLED
		area.visible = false

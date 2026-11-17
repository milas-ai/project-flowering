class_name NPCSpawnPoint
extends Marker3D


@export_enum(
		"Orange",
		"Pink",
		"Green",
		"Brown",
		"Mayor",
) var npc_type: int = 0


func _ready() -> void:
	add_to_group("npc_spawn_points")

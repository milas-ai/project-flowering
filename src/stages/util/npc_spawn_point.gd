class_name NPCSpawnPoint
extends Marker3D


## The dialog text that the NPC will display when interacted with.
@export var dialog_text: String
## The type of NPC that will spawn at this spawn point.
@export_enum(
		"Orange",
		"Pink",
		"Green",
		"Brown",
		"Mayor",
) var npc_type: int = 0


func _ready() -> void:
	add_to_group("npc_spawn_points")

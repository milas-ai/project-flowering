@tool
extends Node3D

@export var energy: float = 6.:
	set(value):
		energy = value
		if lightened: $Light.light_energy = energy
@export var lightened: bool = false:
	set(value):
		lightened = value
		$Light.light_energy = energy if value else 0.
@export var radius: float = 6.:
	set(value):
		radius = value
		$Light.omni_range = value
		$LightArea/CollisionShape3D.shape.radius = value
@export_tool_button("Make unique") var make_unique_action = make_unique 
func make_unique() -> void:
	_enter_tree()


func _enter_tree() -> void:
	# make area unique
	$LightArea/CollisionShape3D.shape = $LightArea/CollisionShape3D.shape.duplicate()
	radius = radius	# set it so that it has the correct radius after copying

func light_up(instant: bool) -> void:
	if lightened: return
	lightened = true
	
	$Light.light_energy = 0.
	if not instant: await get_tree().create_timer(.8).timeout
	var tween = get_tree().create_tween()
	tween.tween_property($Light, "light_energy", 6., .5)
	light_other_lamps()

func light_other_lamps() -> void:
	for entity in $LightArea.get_overlapping_bodies():
		print(entity.name)
		if entity.collision_layer & LayerBitmask.LIGHTABLE:
			entity.light_up(false)
		

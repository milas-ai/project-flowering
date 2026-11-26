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


func light_up(instant: bool) -> void:
	if lightened: return
	lightened = true
	
	if not instant: await get_tree().create_timer(.8).timeout
	var tween = get_tree().create_tween()
	tween.tween_property($Light, "light_energy", 6., .5)
	light_other_lamps()

func light_other_lamps() -> void:
	for entity in $LightArea.get_overlapping_bodies():
		if entity.collision_layer & LayerBitmask.LIGHTABLE:
			entity.light_up(false)
		

extends Node3D

var lightened: bool = false


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
		

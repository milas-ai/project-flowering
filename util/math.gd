extends Node
class_name Math


static func lerpfd(a, b, speed: float, dt: float):
	# lerpfd is a Lerp Frame Dependant by Freya Holmér
	# returns a interpolated towards b by a speed
	# source: https://www.youtube.com/watch?v=LSNQuFEDOyQ&ab_channel=FreyaHolm%C3%A9r
	
	if typeof(a) != typeof(b):
		push_error("Lerpfd with diferent types of a and b")
		return
	
	elif typeof(a) == TYPE_FLOAT:
		return b + (a-b) * exp(-speed*dt)
	
	elif typeof(a) == TYPE_VECTOR2:
		var xcomp = b.x + (a.x-b.x) * exp(-speed*dt)
		var ycomp = b.y + (a.y-b.y) * exp(-speed*dt)
		return Vector2(xcomp, ycomp)
	
	elif typeof(a) == TYPE_VECTOR3:
		var xcomp = b.x + (a.x-b.x) * exp(-speed*dt)
		var ycomp = b.y + (a.y-b.y) * exp(-speed*dt)
		var zcomp = b.z + (a.z-b.z) * exp(-speed*dt)
		return Vector3(xcomp, ycomp, zcomp)
	
	else:
		push_error("Unsuported type for lerpfd")

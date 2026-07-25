extends RigidBody3D

var velocity: Vector3 = Vector3.RIGHT
var speed: float = 1.0

func _process(delta: float) -> void:
	position += velocity * speed * delta

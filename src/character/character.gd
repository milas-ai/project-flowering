@abstract
class_name Character
extends CharacterBody3D


var vertical_velocity := Vector3.ZERO
var horizontal_velocity := Vector3.ZERO
var horizontal_direction := Vector3.ZERO


func _physics_process(delta: float) -> void:
	_fall(delta)
	velocity = horizontal_velocity + vertical_velocity
	move_and_slide()


@abstract func take_damage(amount: int) -> void


func _fall(delta: float) -> void:
	if not is_on_floor():
		vertical_velocity += get_gravity() * delta

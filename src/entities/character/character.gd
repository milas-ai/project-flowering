@abstract
class_name Character
extends CharacterBody3D


var vertical_velocity := Vector3.ZERO
var horizontal_velocity := Vector3.ZERO

@onready var animation_player: AnimationPlayer = $CharacterModel/AnimationPlayer


func _physics_process(delta: float) -> void:
	_fall(delta)
	velocity = horizontal_velocity + vertical_velocity
	move_and_slide()


@abstract func take_damage(amount: int) -> void


func _fall(delta: float) -> void:
	if not is_on_floor():
		vertical_velocity += get_gravity() * delta
	elif vertical_velocity.y > 0:
		vertical_velocity.y += get_gravity().y * delta

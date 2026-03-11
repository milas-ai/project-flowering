extends CharacterBody3D
class_name Character


const BASE_SPEED: float = 5
const JUMP_VELOCITY: float = 7

var vertical_velocity: Vector3 = Vector3.ZERO
var horizontal_velocity: Vector3 = Vector3.ZERO
var horizontal_direction: Vector3 = Vector3.ZERO
var speed: float


func _physics_process(delta: float) -> void:
	fall(delta)
	velocity = horizontal_velocity + vertical_velocity
	move_and_slide()


func fall(delta: float) -> void:
	if not is_on_floor():
		vertical_velocity += get_gravity() * delta

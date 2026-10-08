@abstract
class_name Character
extends CharacterBody3D


const BASE_SPEED: float = 5
const JUMP_VELOCITY: float = 7
const BASE_HEALTH: int = 6

var vertical_velocity := Vector3.ZERO
var horizontal_velocity := Vector3.ZERO
var horizontal_direction := Vector3.ZERO
var speed: float
var _health: int


func _ready() -> void:
	_health = BASE_HEALTH


func _physics_process(delta: float) -> void:
	_fall(delta)
	velocity = horizontal_velocity + vertical_velocity
	move_and_slide()


func take_damage(amount: int) -> void:
	_health -= amount
	if _health <= 0:
		queue_free()


func _fall(delta: float) -> void:
	if not is_on_floor():
		vertical_velocity += get_gravity() * delta

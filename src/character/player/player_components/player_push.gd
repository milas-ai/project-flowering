extends Node
class_name PlayerPush


@export var push_force = 10.0

@onready var player: Player = $"../.."
@onready var player_input: PlayerInput = $"../../Input"
@onready var ray_cast = $"../../CharacterModel/RayCast3D"

var is_pushing: bool = false


func _ready():
	ray_cast.enabled = false

func _on_player_input_push_pressed():
	ray_cast.enabled = true
	ray_cast.force_raycast_update()
	is_pushing = true
	
	if ray_cast.is_colliding():
		var hit_object = ray_cast.get_collider()
		
		if hit_object is RigidBody3D:
			var push_direction = ray_cast.global_transform.basis.z.normalized()
			
			var hit_point = ray_cast.get_collision_point() - hit_object.global_position
			hit_object.apply_impulse(push_direction * push_force, hit_point)

	get_tree().create_timer(0.46).timeout.connect(func(): is_pushing = false; ray_cast.enabled = false)

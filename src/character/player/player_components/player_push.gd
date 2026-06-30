extends Node
class_name PlayerPush

@onready var player: Player = $"../.."
@onready var player_input: PlayerInput = $"../../Input"
@onready var ray_cast = $"../../CharacterModel/RayCast3D"
@export var push_force = 10.0

func _ready():
	ray_cast.enabled = false

func _on_player_input_push_pressed():
	ray_cast.enabled = true
	ray_cast.force_raycast_update()

	print("Is colliding? ", ray_cast.is_colliding())
	if ray_cast.is_colliding():
		print("Hit object: ", ray_cast.get_collider().name)

	var forward_vector = ray_cast.global_transform.basis.z.normalized()
	print("Player Global Position: ", player.global_position)
	print("Raycast Forward Vector: ", forward_vector)
	
	if ray_cast.is_colliding():
		var hit_object = ray_cast.get_collider()
		
		if hit_object is RigidBody3D:
			if hit_object.freeze:
				hit_object.freeze = false
			
			var push_direction = ray_cast.global_transform.basis.z.normalized()
			
			var hit_point = ray_cast.get_collision_point() - hit_object.global_position
			hit_object.apply_impulse(push_direction * push_force, hit_point)


	ray_cast.enabled = false

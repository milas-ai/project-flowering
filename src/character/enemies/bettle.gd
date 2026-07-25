extends Enemy
class_name Bettle

signal shoot(bullet, direction, location, speed)

var Bullet = preload("res://src/entities/bullet.tscn")

@export var bullet_speed: float = 10.0


func attack_player() -> void:
  look_at(player.global_transform.origin, Vector3.UP)
  rotation.x = 0
  shoot.emit(Bullet, rotation, global_transform.origin + Vector3.UP * 0.5 - global_transform.basis.z, bullet_speed)

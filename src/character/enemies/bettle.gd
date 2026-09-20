extends Enemy
class_name Bettle


signal shoot(bullet, direction, location, speed)

@export var bullet_speed: float = 10.0

var Bullet = preload("res://src/entities/bullet.tscn")


func attack_player() -> void:
  look_at(player.global_transform.origin, Vector3.UP)
  rotation.x = 0
  animation_player.stop()
  animation_player.clear_queue()
  animation_player.play("attack")
  get_tree().create_timer(0.72).timeout.connect(func(): shoot.emit(Bullet, rotation, global_transform.origin + Vector3.UP * 0.5 - global_transform.basis.z, bullet_speed))
  animation_player.queue("idle")

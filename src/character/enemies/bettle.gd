class_name Bettle
extends Enemy


signal shoot(bullet, direction, location, speed)

@export var _bullet_speed: float = 10.0

var Bullet: PackedScene = preload("res://src/entities/bullet.tscn")


func attack_player() -> void:
  look_at(player.global_transform.origin, Vector3.UP)
  rotation.x = 0
  animation_player.stop()
  animation_player.clear_queue()
  animation_player.play("attack")
  ParticleSystem.play(ParticleID.ACID_SPEW, $BulletMarker.global_transform.origin, global_rotation)
  get_tree().create_timer(0.72).timeout.connect(func(): shoot.emit(Bullet, rotation, $BulletMarker.global_transform.origin, _bullet_speed))
  animation_player.queue("idle")

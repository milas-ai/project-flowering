extends Enemy
class_name Ant


const SPEED: float = 7

func attack_player() -> void:
  look_at(player.global_transform.origin, Vector3.UP)
  rotation.x = 0
  animation_player.stop()
  animation_player.clear_queue()
  animation_player.play("attack")
  get_tree().create_timer(0.67).timeout.connect(func(): if player_on_near_sight: player.take_damage(100))
  animation_player.queue("idle")

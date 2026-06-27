extends Character
class_name Enemy

@onready var player: Player = $"../Player"

var in_cooldown: bool = false

const friction: float = 25


func attack_player() -> void:
	if player.health > 0 and not in_cooldown:
		print(self.name + " attacks the player!")
		player.take_damage(10)
		in_cooldown = true
		await get_tree().create_timer(2.0).timeout
		in_cooldown = false

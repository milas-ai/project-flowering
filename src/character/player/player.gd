class_name Player
extends Character


signal update_health(health: int)

var input_direction := Vector3.ZERO

@onready var _character_model: Node3D = $CharacterModel


var _health: int = BaseStat.PLAYER.HEALTH:
	set(value):
		_health = value
		emit_signal("update_health", _health)


func _ready() -> void:
	$"CharacterModel/HurtboxComponent3D".damage = BaseStat.PLAYER.DAMAGE


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	horizontal_velocity = velocity * Vector3(1,0,1)
	vertical_velocity = velocity * Vector3(0,1,0)


func process_horizontal_movement(delta: float, direction_vector: Vector3, speed: float) -> void:
	if direction_vector.length() > 0.1:
		if horizontal_velocity.length() > 2 * speed:
			horizontal_velocity = horizontal_velocity.lerp(
					direction_vector * speed, BaseStat.PLAYER.SLIDE_FRICTION * delta
			)
		else:
			horizontal_velocity = direction_vector * speed
	else:
		horizontal_velocity = horizontal_velocity.lerp(Vector3.ZERO, BaseStat.PLAYER.FRICTION * delta)


func process_rotation(is_sliding: bool) -> void:
	if input_direction.length() > 0.1:
		_character_model.look_at(_character_model.global_position + input_direction, Vector3.UP, true)
	
	if is_sliding:
		_character_model.look_at(_character_model.global_position + horizontal_velocity, get_floor_normal(), true)


func take_damage(amount: int) -> void:
	_health -= amount
	if _health <= 0:
		get_tree().quit()

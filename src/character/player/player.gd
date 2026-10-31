class_name Player
extends Character


signal update_health(health: int)
signal dead()

var input_direction := Vector3.ZERO

@onready var _character_model: Node3D = $CharacterModel


var health: int = BaseStat.PLAYER.HEALTH:
	set(value):
		health = value
		emit_signal("update_health", health)


func _ready() -> void:
	$"CharacterModel/HurtboxComponent3D".damage = BaseStat.PLAYER.DAMAGE


func _process(_delta: float) -> void:
	RenderingServer.global_shader_parameter_set("player_position", global_position)


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
		if is_on_floor():
			horizontal_velocity = horizontal_velocity.lerp(Vector3.ZERO, BaseStat.PLAYER.FRICTION * delta)
		else:
			horizontal_velocity = horizontal_velocity.lerp(Vector3.ZERO, delta)


func process_rotation(is_sliding: bool) -> void:
	if input_direction.length() > 0.1:
		_character_model.look_at(_character_model.global_position + input_direction, Vector3.UP, true)
	
	if is_sliding:
		if get_floor_normal().length() > 0.1:
			_character_model.look_at(_character_model.global_position + horizontal_velocity, get_floor_normal(), true)


func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		emit_signal("dead")

class_name RolyPoly
extends Enemy


static var SPEED: float = BaseStat.ENEMY.ROLY_POLY.SPEED
static var FRICTION: float = BaseStat.ENEMY.ROLY_POLY.FRICTION

@onready var _explosion_area: Area3D = $ExplosionArea
@onready var _material: Material = $CharacterModel/controller/Skeleton3D/controller.get_active_material(0)


func _ready() -> void:
	_health = BaseStat.ENEMY.ROLY_POLY.HEALTH
	

func attack_player() -> void:
	look_at(player.global_transform.origin, Vector3.UP)
	rotation.x = 0
	animation_player.stop()
	animation_player.clear_queue()
	animation_player.play("attack")
	animation_player.queue("roll")
	get_tree().create_timer(1.0).timeout.connect(
			func():
				horizontal_velocity = -global_transform.basis.z * SPEED
	)
	while true:
		await get_tree().physics_frame
		for i in get_slide_collision_count():
			var collider: Object = get_slide_collision(i).get_collider()
			if collider and "collision_layer" in collider:
				if collider.collision_layer & ~LayerBitmask.WORLD:
					_explode()


func apply_stun() -> void:
	animation_player.play("roll")
	_state_machine.transition_to("StateEnemyStunned")
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	var flash_duration: float = 0.3
	var min_duration: float = 0.05
	var acceleration: float = 0.75

	while flash_duration > min_duration:
		tween.tween_property(_material, "emission_energy_multiplier", 1.0, flash_duration)
		tween.tween_property(_material, "emission_energy_multiplier", 0.0, flash_duration)
		flash_duration *= acceleration
	tween.tween_callback(_explode)


func take_damage(amount: int) -> void:
	if _state_machine.get_current_state() != "StateEnemyAttack":
		_health -= amount
		if _health <= 0:
			queue_free()


func _explode() -> void:
	for body in _explosion_area.get_overlapping_bodies():
		if body.collision_layer & LayerBitmask.PUSHABLE:
			var push_direction: Vector3 = global_transform.origin.direction_to(body.global_transform.origin)
			push_direction.y = 0
			body.apply_impulse(push_direction * 10)
		elif body.has_method("take_damage"):
			body.take_damage(BaseStat.ENEMY.ROLY_POLY.DAMAGE)
	ParticleSystem.play(ParticleID.EXPLOSION, global_transform.origin)
	queue_free()
	
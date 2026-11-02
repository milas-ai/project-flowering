class_name Ant
extends Enemy


static var SPEED: float = BaseStat.ENEMY.ANT.SPEED
static var FRICTION: float = BaseStat.ENEMY.ANT.FRICTION

@onready var _hurtbox := $HurtboxComponent3D


func _ready() -> void:
	_health = BaseStat.ENEMY.ANT.HEALTH
	_hurtbox.damage = BaseStat.ENEMY.ANT.DAMAGE


func attack_player() -> void:
	look_at(player.global_transform.origin, Vector3.UP)
	_hurtbox.look_at(player.global_transform.origin, Vector3.UP)
	rotation.x = 0
	animation_player.stop()
	animation_player.clear_queue()
	animation_player.play("attack")
	get_tree().create_timer(0.67).timeout.connect(_activate_hurtbox)
	animation_player.queue("idle")


func _activate_hurtbox() -> void:
	_hurtbox.process_mode = Node.PROCESS_MODE_INHERIT
	get_tree().create_timer(0.25).timeout.connect(
			func():
				_hurtbox.process_mode = Node.PROCESS_MODE_DISABLED
	)

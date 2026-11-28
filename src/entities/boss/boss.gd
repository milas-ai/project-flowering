class_name Boss
extends StaticBody3D


var _health: int = BaseStat.BOSS.HEALTH

@onready var animation_player: AnimationPlayer = $CharacterModel/AnimationPlayer
@onready var material: StandardMaterial3D = $CharacterModel/Armature/Skeleton3D/Bone/face_004.get_active_material(0)
@onready var web_shot_scene: PackedScene = preload(SceneUID.ENTITIES.WEB_SHOT)
@onready var state_machine: StateMachine = $StateMachine
@onready var _player: Node3D = $/root/MainGame.player
@onready var _entity_root: Node3D = $/root/MainGame.entity_root
@onready var _shoot_marker: Marker3D = $Markers/ShootMarker


func attack_player() -> void:
	animation_player.stop()
	animation_player.clear_queue()
	animation_player.play("fire")
	get_tree().create_timer(0.72).timeout.connect(
			func():
				if state_machine.get_current_state() == "StateBossAttack":
					_shoot_player())


func apply_stun() -> void:
	if state_machine.get_current_state() == "StateBossAttack":
		state_machine.transition_to("StateBossStunned")


func take_damage(amount: int) -> void:
	if _health > 0 and state_machine.get_current_state() == "StateBossStunned":
		_health -= amount
		state_machine.transition_to("StateBossHurt")
		if _health <= 0:
			state_machine.transition_to("StateBossDead")


func _shoot_player() -> void:
	# ParticleSystem.play(ParticleID.SPIDER_SHOOT, _shoot_marker.global_transform.origin, global_rotation)
	var spawned_bullet: WebShot = web_shot_scene.instantiate()
	_entity_root.add_child(spawned_bullet)
	spawned_bullet.position = _shoot_marker.global_transform.origin
	spawned_bullet.look_at(_player.global_transform.origin, Vector3.UP)
	spawned_bullet.rotation.x = 0
	spawned_bullet.velocity = -spawned_bullet.global_transform.basis.z
	spawned_bullet.speed = BaseStat.BOSS.BULLET_SPEED

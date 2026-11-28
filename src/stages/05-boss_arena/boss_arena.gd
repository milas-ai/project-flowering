extends BaseStage


var hole_markers: Array[Marker3D]
var _player_on_center_area: bool = false

@onready var player: Player
@onready var boss: Boss = $BossComponents/Boss
@onready var spider_leg_center: SpiderLeg = $BossComponents/SpiderLegCenter
@onready var spider_leg_side: SpiderLeg = $BossComponents/SpiderLegSide
@onready var stomp_light_center: SpotLight3D = $BossComponents/StompLightCenter
@onready var stomp_light_side: SpotLight3D = $BossComponents/StompLightSide
@onready var _state_machine: StateMachine = $StateMachine


func _ready() -> void:
	super._ready()
	player = _main_game.player
	hole_markers = [
		$Markers/HoleMarker,
		$Markers/HoleMarker2,
		$Markers/HoleMarker3,
		$Markers/HoleMarker4
	]


func _on_door_closing_area_body_entered(_body: Node3D) -> void:
	call_deferred("_close_door")


func _close_door() -> void:
	%DoorClosingArea.process_mode = Node3D.PROCESS_MODE_DISABLED
	%DoorCollision.process_mode = Node3D.PROCESS_MODE_INHERIT

	var spawned_bullet: WebShot = boss.web_shot_scene.instantiate()
	spawned_bullet.collision_mask = LayerBitmask.WORLD
	_main_game.entity_root.add_child(spawned_bullet)
	spawned_bullet.position = %DoorClosingShotPosition.global_position
	spawned_bullet.rotation = %DoorClosingShotPosition.global_rotation
	spawned_bullet.velocity = spawned_bullet.global_transform.basis.z
	spawned_bullet.speed = BaseStat.BOSS.BULLET_SPEED * 1.5
	spawned_bullet.collided.connect(_on_door_closing_shot_collided)


func _on_door_closing_shot_collided() -> void:
	%WebEntrance.show()
	%WebEntrance2.show()
	%WebEntrance3.show()
	_start_boss_fight()


func _start_boss_fight() -> void:
	var demo_stomp_marker: Marker3D = $Markers/DemoStompMarker
	var angle: float = demo_stomp_marker.rotation.y
	await _stomp(spider_leg_side, stomp_light_side, demo_stomp_marker.global_position, PI/2 - angle)


func _stomp(spider_leg: SpiderLeg, spot_light: SpotLight3D, stomp_position: Vector3, leg_angle: float) -> void:
	spider_leg.process_mode = Node3D.PROCESS_MODE_INHERIT
	spider_leg.position = stomp_position
	spider_leg.rotation.y = leg_angle
	await spider_leg.reset()
	spider_leg.show()

	spot_light.position.x = stomp_position.x
	spot_light.position.z = stomp_position.z
	spot_light.position.y = 0.0
	var tween := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(spot_light, "position:y", 6.67, BaseStat.BOSS.STOMP_WARMUP_TIME)
	await tween.finished
	
	spider_leg.stomp()
	await get_tree().create_timer(0.27).timeout
	ParticleSystem.play(ParticleID.RAISE_DUST, stomp_position + Vector3.UP * 0.25)
	spot_light.position.y = 0.0
	await get_tree().create_timer(BaseStat.BOSS.SIDE_STOMP_COOLDOWN).timeout
	spider_leg.process_mode = Node3D.PROCESS_MODE_DISABLED
	spider_leg.hide()


func _pick_random_close_angle() -> float:
	var player_position: Vector3 = player.global_transform.origin
	var _player_quarter: int
	
	if player_position.x > 0:
		if player_position.z > 0:
			_player_quarter = 1
		else:
			_player_quarter = 4
	else:
		if player_position.z > 0:
			_player_quarter = 2
		else:
			_player_quarter = 3

	return (PI / 2) * randf_range(_player_quarter - 1, _player_quarter)


func _on_center_area_body_entered(_body: Node3D) -> void:
	_player_on_center_area = true


func _on_center_area_body_exited(_body: Node3D) -> void:
	_player_on_center_area = false

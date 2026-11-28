extends BaseStage


var _hole_markers: Array[Marker3D]
var _player_on_center_area: bool = false
var _player_quarter_position: int = 0

@onready var _boss: Boss = $BossComponents/Boss


func _ready() -> void:
	super._ready()
	_main_game.player.rotation.y = PI
	_hole_markers = [
		$Markers/HoleMarker,
		$Markers/HoleMarker2,
		$Markers/HoleMarker3,
		$Markers/HoleMarker4
	]

	_boss.show()
	_boss.process_mode = Node3D.PROCESS_MODE_INHERIT
	_boss.position = _hole_markers[0].global_position
	_boss.rotation = _hole_markers[0].global_rotation


func _on_door_closing_area_body_entered(_body: Node3D) -> void:
	call_deferred("_close_door")


func _close_door() -> void:
	%DoorClosingArea.process_mode = Node3D.PROCESS_MODE_DISABLED
	%DoorCollision.process_mode = Node3D.PROCESS_MODE_INHERIT

	var spawned_bullet: WebShot = _boss.web_shot_scene.instantiate()
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


func _on_center_area_body_entered(_body: Node3D) -> void:
	_player_on_center_area = true
	var positionx = _pick_random_close_position()
	print(positionx)
	$BossComponents/SpiderLegSide.position = positionx
	$SpotLight3D.position.x = positionx.x
	$SpotLight3D.position.z = positionx.z


func _on_center_area_body_exited(_body: Node3D) -> void:
	_player_on_center_area = false


func _pick_random_close_position() -> Vector3:
	var angle: float = (PI / 2) * randf_range(
			_player_quarter_position - 1,
			_player_quarter_position)
	return Vector3(20.0 * cos(angle), 0, 20.0 * sin(angle))


func _on_first_quarter_area_body_entered(_body: Node3D) -> void:
	_player_quarter_position = 1


func _on_second_quarter_area_body_entered(_body: Node3D) -> void:
	_player_quarter_position = 2


func _on_third_quarter_area_body_entered(_body: Node3D) -> void:
	_player_quarter_position = 3


func _on_fourth_quarter_area_body_entered(_body: Node3D) -> void:
	_player_quarter_position = 4

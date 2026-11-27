extends BaseStage


@onready var _web_shot_scene: PackedScene = preload(SceneUID.ENTITIES.WEB_SHOT)


func _ready() -> void:
	super._ready()
	_main_game.player.rotation.y = PI


func _on_door_closing_area_body_entered(_body: Node3D) -> void:
	call_deferred("_close_door")


func _close_door() -> void:
	%DoorClosingArea.process_mode = Node3D.PROCESS_MODE_DISABLED
	%DoorCollision.process_mode = Node3D.PROCESS_MODE_INHERIT

	var spawned_bullet: WebShot = _web_shot_scene.instantiate()
	spawned_bullet.collision_mask = LayerBitmask.WORLD
	_main_game.entity_root.add_child(spawned_bullet)
	spawned_bullet.position = %DoorClosingShotPosition.global_position
	spawned_bullet.rotation = %DoorClosingShotPosition.global_rotation
	spawned_bullet.velocity = spawned_bullet.global_transform.basis.z
	spawned_bullet.speed = BaseStat.ENEMY.BOSS.BULLET_SPEED * 2
	spawned_bullet.collided.connect(_on_door_closing_shot_collided)


func _on_door_closing_shot_collided() -> void:
	%WebEntrance.show()
	%WebEntrance2.show()
	%WebEntrance3.show()

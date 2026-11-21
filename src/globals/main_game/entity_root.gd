class_name EntityRoot
extends Node3D


@onready var _main_game: MainGame = $/root/MainGame
@onready var _beetle_bullet_scene: PackedScene = preload(SceneUID.ENTITIES.BEETLE_BULLET)
@onready var _roly_poly_scene: PackedScene = preload(SceneUID.ENEMIES.ROLY_POLY)
@onready var _beetle_scene: PackedScene = preload(SceneUID.ENEMIES.BEETLE)
@onready var _ant_scene: PackedScene = preload(SceneUID.ENEMIES.ANT)
@onready var _orange_npc_scene: PackedScene = preload(SceneUID.NPCS.ORANGE)
@onready var _pink_npc_scene: PackedScene = preload(SceneUID.NPCS.PINK)
@onready var _green_npc_scene: PackedScene = preload(SceneUID.NPCS.GREEN)
@onready var _brown_npc_scene: PackedScene = preload(SceneUID.NPCS.BROWN)
@onready var _mayor_npc_scene: PackedScene = preload(SceneUID.NPCS.MAYOR)


func spawn_enemies(spawn_points: Array) -> void:
	for spawn_point in spawn_points:
		var enemy: Enemy
		if spawn_point is BeetleSpawnPoint:
			enemy = _beetle_scene.instantiate() as Enemy
			enemy.shoot.connect(_on_beetle_shoot)
		elif spawn_point is RolyPolySpawnPoint:
			enemy = _roly_poly_scene.instantiate() as Enemy
		elif spawn_point is AntSpawnPoint:
			enemy = _ant_scene.instantiate() as Enemy
		else:
			push_error("Unknown spawn point type: %s" % spawn_point)
			continue
		spawn_point.setup_enemy(enemy)
		add_child(enemy)


func spawn_npcs(spawn_points: Array) -> void:
	for spawn_point in spawn_points:
		var npc: NPC
		match spawn_point.npc_type:
			0:
				npc = _orange_npc_scene.instantiate() as NPC
			1:
				npc = _pink_npc_scene.instantiate() as NPC
			2:
				npc = _green_npc_scene.instantiate() as NPC
			3:
				npc = _brown_npc_scene.instantiate() as NPC
			4:
				npc = _mayor_npc_scene.instantiate() as NPC
			_:
				push_error("Unknown NPC type: %s" % spawn_point.npc_type)
				continue
		npc.position = spawn_point.global_position
		npc.rotation = spawn_point.global_rotation
		add_child(npc)
		npc.dialog_finished.connect(_main_game._current_stage._on_npc_dialog_finished)


func _on_beetle_shoot(direction: Vector3, location: Vector3, speed: float) -> void:
	var spawned_bullet: BeetleBullet = _beetle_bullet_scene.instantiate()
	add_child(spawned_bullet)
	spawned_bullet.rotation = direction
	spawned_bullet.position = location
	spawned_bullet.velocity = -spawned_bullet.global_transform.basis.z
	spawned_bullet.speed = speed

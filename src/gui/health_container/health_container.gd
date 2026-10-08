extends HBoxContainer


@onready var _hearts: Array[Node]
@onready var _empty_heart_texture: Texture2D = load("res://assets/gui/empty_heart.png")
@onready var _half_heart_texture: Texture2D = load("res://assets/gui/half_heart.png")
@onready var _full_heart_texture: Texture2D = load("res://assets/gui/full_heart.png")


func _ready() -> void:
	for i in range(int(float(BaseStat.PLAYER.HEALTH) / 2) + BaseStat.PLAYER.HEALTH%2):
		var texture_rect := TextureRect.new()
		texture_rect.texture = _full_heart_texture
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		texture_rect.offset_transform_enabled = true
		add_child(texture_rect)
		_hearts.append(texture_rect)


func _animate_heart(index: int) -> void:
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(_hearts[index], "offset_transform_rotation", deg_to_rad(15), 0.1).as_relative()
	tween.parallel().tween_property(_hearts[index], "offset_transform_scale", Vector2(0.9, 0.9), 0.1)
	tween.tween_property(_hearts[index], "offset_transform_rotation", deg_to_rad(-30), 0.1).as_relative()
	tween.tween_property(_hearts[index], "offset_transform_rotation", deg_to_rad(15), 0.1).as_relative()
	tween.parallel().tween_property(_hearts[index], "offset_transform_scale", Vector2(1, 1), 0.1)


func _on_player_update_health(health: int) -> void:
	for i in range(int(float(BaseStat.PLAYER.HEALTH) / 2) + BaseStat.PLAYER.HEALTH%2):
		if health >= (i*2+1)+1:
			if _hearts[i].texture != _full_heart_texture:
				_animate_heart(i)
				_hearts[i].texture = _full_heart_texture
		elif health >= i*2+1:
			if _hearts[i].texture != _half_heart_texture:
				_animate_heart(i)
				_hearts[i].texture = _half_heart_texture
		else:
			if _hearts[i].texture != _empty_heart_texture:
				_animate_heart(i)
				_hearts[i].texture = _empty_heart_texture

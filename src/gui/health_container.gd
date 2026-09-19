extends HBoxContainer


const MAX_HEALTH = 6

@onready var hearts: Array[Node]
@onready var empty_heart_texture: Texture2D = load("res://assets/gui/empty_heart.png")
@onready var half_heart_texture: Texture2D = load("res://assets/gui/half_heart.png")
@onready var full_heart_texture: Texture2D = load("res://assets/gui/full_heart.png")


func _ready() -> void:
	for i in range(MAX_HEALTH/2 + MAX_HEALTH%2):
		var texture_rect = TextureRect.new()
		texture_rect.texture = full_heart_texture
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		add_child(texture_rect)
		hearts.append(texture_rect)

func _on_player_update_health(health) -> void:
	for i in range(MAX_HEALTH/2 + MAX_HEALTH%2):
		if health >= (i*2+1)+1:
			hearts[i].texture = full_heart_texture
		elif health >= i*2+1:
			hearts[i].texture = half_heart_texture
		else:
			hearts[i].texture = empty_heart_texture

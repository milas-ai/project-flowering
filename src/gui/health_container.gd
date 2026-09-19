extends HBoxContainer

@onready var hearts: Array[Node] = get_children()
@onready var empty_heart_texture: Texture2D = load("res://assets/gui/empty_heart.png")
@onready var half_heart_texture: Texture2D = load("res://assets/gui/half_heart.png")
@onready var full_heart_texture: Texture2D = load("res://assets/gui/full_heart.png")


func _on_player_update_health(health, max_health) -> void:
	for i in range(health/2):
		hearts[i].texture = full_heart_texture
	if health % 2 == 1:
		hearts[health/2].texture = half_heart_texture
		for i in range(health/2+1, max_health/2 + max_health%2):
				hearts[i].texture = empty_heart_texture
	else:
		for i in range(health/2, max_health/2 + max_health%2):
			hearts[i].texture = empty_heart_texture
	
	#for i in range(max_health/2 + max_health%2):
		#if (i+1)*2 < health:
			#hearts[i].visible = true
			#if i+2 < health:
				#hearts[i].texture = full_heart_texture
				#i += 1
			#else:
				#hearts[i].texture = half_heart_texture
		#else:
			#hearts[i].visible = false
			

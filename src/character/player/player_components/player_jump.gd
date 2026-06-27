extends Node
class_name PlayerJump


@onready var player: Player = $"../.."
@onready var player_slide: PlayerSlide = $"../Slide"

var was_on_floor: bool = false
@onready var jump_buff_timer: Timer = $JumpBuffer
var jump_buffer: bool = false
@onready var coyote_timer: Timer = $CoyoteTime
var coyote_time: bool = false


func _on_player_input_jump_pressed() -> void:
	jump_buffer = true
	jump_buff_timer.start()


func _physics_process(_delta: float) -> void:
	update_coyote()
	if jump_buffer and coyote_time:
		jump(player.JUMP_VELOCITY)


func jump(impulse: float) -> void:
	player.vertical_velocity.y = impulse
	jump_buffer = false

	if player_slide.is_sliding:
		player_slide.stop_slide()


func update_coyote() -> void:
	if player.is_on_floor():
		coyote_time = true
		was_on_floor = true
	else:
		if was_on_floor:
			coyote_timer.start()
		was_on_floor = false


func _on_jump_buffer_timeout() -> void:
	jump_buffer = false

func _on_coyote_time_timeout() -> void:
	coyote_time = false

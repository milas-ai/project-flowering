extends Node

class_name State

@onready var state_machine: StateMachine = get_parent()
@onready var body: Node = state_machine.body

var elapsed_time: float = 0.0

func enter() -> void:
	elapsed_time = 0
	_enter()

func update(delta: float) -> void:
	elapsed_time += delta
	_update(delta)


func _enter() -> void:
	return

func _exit() -> void:
	return

func _update(_delta: float) -> void:
	pass

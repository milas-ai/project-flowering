@abstract
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

@abstract func _enter() -> void

@abstract func _exit() -> void

@abstract func _update(_delta: float) -> void

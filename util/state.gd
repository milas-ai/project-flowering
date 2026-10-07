@abstract
class_name State
extends Node


@onready var state_machine: StateMachine = get_parent()
@onready var body: Node = state_machine.body


@abstract func enter() -> void


@abstract func update(_delta: float) -> void


@abstract func exit() -> void

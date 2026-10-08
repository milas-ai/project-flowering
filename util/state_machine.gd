class_name StateMachine
extends Node


@export var body: Node

var _state: State = null
var _previous_state: State = null
var _states: Dictionary[StringName, State] = {}


func _ready() -> void:    
	for child in get_children():
		_states[child.name] = child
	transition_to.call_deferred(get_child(0).name)


func _physics_process(delta: float) -> void:
	if _state != null:
		_state.update(delta)


func transition_to(state_name: StringName) -> void:
	_previous_state = _state
	_state = _states[state_name]
	
	if _state != _previous_state:
		if _previous_state != null:
			_previous_state.exit()
		if _state != null:
			_state.enter()

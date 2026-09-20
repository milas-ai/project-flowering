extends Node
class_name StateMachine


@export var body: Node

var state: State = null
var previous_state: State = null
var states: Dictionary[StringName, State] = {}


func _ready() -> void:    
	transition_to.call_deferred(get_child(0).name)
	for child in get_children():
		states[child.name] = child


func _physics_process(delta: float) -> void:
	if state != null:
		state.update(delta)


func transition_to(state_name: StringName) -> void:
	previous_state = state
	state = states[state_name]
	
	if state != previous_state:
		if previous_state != null:
			previous_state._exit()
		if state != null:
			state.enter()

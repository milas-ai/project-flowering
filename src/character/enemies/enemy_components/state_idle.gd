extends State

class_name StateIdle


func _enter():
  state_machine.set_state("StateChase")

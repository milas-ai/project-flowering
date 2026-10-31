class_name HurtboxComponent3D
extends Area3D


var damage: int


func _ready():
	body_entered.connect(_on_body_entered)
	process_mode = Node.PROCESS_MODE_DISABLED


func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)

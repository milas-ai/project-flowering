class_name CheckPointArea
extends Area3D


@onready var _parent_stage: Node3D = get_parent()
@onready var _checkpoint_marker := $Marker3D


func _ready() -> void:
	while not _parent_stage is BaseStage:
		_parent_stage = _parent_stage.get_parent()

	body_entered.connect(_on_body_entered)


func _on_body_entered(_body: Node3D) -> void:
	_parent_stage.current_checkpoint = _checkpoint_marker
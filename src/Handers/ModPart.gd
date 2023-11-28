@tool
class_name ModPart extends Node

var resource : ResourceInfo = null:
	set = _resource_setter;
var actor    : Node2D:
	set = _actor_setter;

func _resource_setter(val):
	if resource != val:
		if resource != null:
			resource.changed.disconnect(update);
		if val != null:
			val.changed.connect(update);
		resource = val;

func _actor_setter(val):
	actor = val;

func init() -> void:
	pass

func update() -> void:
	pass;

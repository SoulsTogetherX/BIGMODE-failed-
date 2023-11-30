@tool
extends ModPart

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

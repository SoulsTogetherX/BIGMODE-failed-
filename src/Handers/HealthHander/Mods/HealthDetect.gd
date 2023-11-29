@tool
extends ModPart

@export var health_storage : ModPart;

func init() -> void:
	pass;

func _actor_setter(val):
	if actor != null:
		actor.changeHealth.disconnect(_on_health_change);
	if val != null:
		val.changeHealth.connect(_on_health_change);
	actor = val;

func update() -> void:
	pass;

func _on_health_change(delta : int) -> void:
	health_storage.health_change(delta);

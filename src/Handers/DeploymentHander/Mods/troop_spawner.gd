@tool
extends ModPart

@export var storage : ModPart;

func _resource_setter(val):
	if resource != val:
		if resource != null:
			resource.changed.disconnect(update);
		if val != null:
			val.changed.connect(update);
			resource = val;
			return;
		
		resource = null;

func spawn_all() -> void:
	if resource.troop_type == null:
		return;
	
	var troops : Array[Troop];
	for i in resource.max_troops:
		troops.append((resource.troop_type.instantiate() as Troop));
	
	storage.set_troops(troops);

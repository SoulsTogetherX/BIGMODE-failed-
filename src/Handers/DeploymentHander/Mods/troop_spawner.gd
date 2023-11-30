@tool
extends ModPart

@export var storage : ModPart;

const scene : PackedScene = preload("res://src/objects/Troops/Dummy_Troop.tscn");

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
		var t : Troop = (scene.instantiate() as Troop);
		t.init(resource.troop_info);
		troops.append(t);
	
	storage.set_troops(troops);

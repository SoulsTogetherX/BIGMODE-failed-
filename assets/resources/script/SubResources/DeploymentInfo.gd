@tool
class_name DeploymentInfo extends ResourceInfo

@export var max_troops         : int:
	set(val):
		if max_troops != val:
			max_troops = val;
			emit_changed();

@export var troop_regeneration : int:
	set(val):
		if troop_regeneration != val:
			troop_regeneration = val;
			emit_changed();

@export var troop_type         : PackedScene:
	set(val):
		if troop_type != val:
			troop_type = val;
			emit_changed();

func get_id():
	return "DeploymentInfo";

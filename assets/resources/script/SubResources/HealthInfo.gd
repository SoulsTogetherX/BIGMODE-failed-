@tool
class_name HealthInfo extends ResourceInfo

@export var max_health          : int:
	set(val):
		if max_health != val:
			max_health = val;
			emit_changed();

@export var health_regeneration : int:
	set(val):
		if health_regeneration != val:
			health_regeneration = val;
			emit_changed();

func get_id():
	return "HealthInfo";

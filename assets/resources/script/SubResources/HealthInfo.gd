@tool
class_name HealthInfo extends ResourceInfo

enum HEALTH_SIGNAL {HEALED = 0, DAMAGED = 1, KILLED = 2, REVIVED = 3, NONE = 4};

@export var max_health          : int:
	set(val):
		if max_health != val:
			max_health = val;
			current_health = min(current_health, val);
			emit_changed();

@export var health_regeneration : int:
	set(val):
		if health_regeneration != val:
			health_regeneration = val;
			emit_changed();

var current_health : int = 0:
	set(val):
		current_health = clamp(val, 0, max_health);

func health_change(delta : int) -> HEALTH_SIGNAL:
	var prev : int = current_health;
	current_health += delta;
	if prev == current_health:
		return HEALTH_SIGNAL.NONE;
	
	if delta > 0:
		if prev == 0:
			return HEALTH_SIGNAL.REVIVED;
		return HEALTH_SIGNAL.HEALED;
	else:
		if current_health == 0:
			return HEALTH_SIGNAL.KILLED;
		return HEALTH_SIGNAL.DAMAGED;

func recover_all_health() -> void:
	current_health = max_health;

func get_id():
	return "HealthInfo";

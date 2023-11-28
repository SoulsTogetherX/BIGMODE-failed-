@tool
class_name TroopInfo extends ResourceInfo

@export var health  : HealthInfo:
	set(val):
		if health != val:
			if val != null:
				val.changed.connect(emit_changed);
			if health != null:
				health.changed.disconnect(emit_changed);
			
			health = val;
			emit_changed();

@export var attack  : AttackInfo:
	set(val):
		if attack != val:
			if val != null:
				val.changed.connect(emit_changed);
			if attack != null:
				attack.changed.disconnect(emit_changed);
			
			attack = val;
			emit_changed();

@export var carry_strength : float:
	set(val):
		if carry_strength != val:
			carry_strength = val;
			emit_changed();

@export var move_speed     : float:
	set(val):
		if move_speed != val:
			move_speed = val;
			emit_changed();

func get_id():
	return "TroopInfo";

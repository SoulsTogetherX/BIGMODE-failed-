@tool
class_name RangeInfo extends ResourceInfo

enum PRIORTIZE {CLOSE = 0, FAR = 1};
@export var priority : PRIORTIZE:
	set(val):
		if priority != val:
			priority = val;
			emit_changed();

@export var attack           : AttackInfo:
	set(val):
		if attack != val:
			if val != null:
				val.changed.connect(emit_changed);
			if attack != null:
				attack.changed.disconnect(emit_changed);
			
			attack = val;
			emit_changed();

@export var attack_speed : float:
	set(val):
		if attack_speed != val:
			attack_speed = val;
			emit_changed();

@export var projectile_speed : float:
	set(val):
		if projectile_speed != val:
			projectile_speed = val;
			emit_changed();

@export var projectile : PackedScene:
	set(val):
		if projectile != val:
			projectile = val;
			emit_changed();

func get_id():
	return "RangeInfo";

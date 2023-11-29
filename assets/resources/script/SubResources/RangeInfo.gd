@tool
class_name RangeInfo extends ResourceInfo

enum PRIORTIZE {CLOSE = 0, FAR = 1};
@export var priority : PRIORTIZE:
	set(val):
		if priority != val:
			priority = val;
			emit_changed();

@export var delta : HealthDeltaInfo:
	set(val):
		if delta != val:
			if val != null:
				val.changed.connect(emit_changed);
			if delta != null:
				delta.changed.disconnect(emit_changed);
			
			delta = val;
			emit_changed();

@export var shoot_speed : float:
	set(val):
		if shoot_speed != val:
			shoot_speed = val;
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

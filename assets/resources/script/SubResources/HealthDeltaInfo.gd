@tool
class_name HealthDeltaInfo extends ResourceInfo

@export var delta      : int:
	set(val):
		if delta != val:
			delta = val;
			emit_changed();

@export var range       : float:
	set(val):
		if range != val:
			range = val;
			emit_changed();

@export var target_type : BlankTargetInfo:
	set(val):
		if target_type != val:
			target_type = val;
			emit_changed();

@export var targets : Array[ALLEGIANCE]:
	set(val):
		if targets != val:
			targets = val;
			emit_changed();

func get_id():
	return "AttackInfo";

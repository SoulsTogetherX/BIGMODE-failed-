@tool
class_name AttackInfo extends ResourceInfo

@export var damage      : int:
	set(val):
		if damage != val:
			damage = val;
			emit_changed();

@export var range       : float:
	set(val):
		if range != val:
			range = val;
			emit_changed();

@export var attack_type : AttackTypeInfo:
	set(val):
		if attack_type != val:
			if val != null:
				val.changed.connect(emit_changed);
			if attack_type != null:
				attack_type.changed.disconnect(emit_changed);
			
			attack_type = val;
			emit_changed();

@export var targets : Array[Troop.TROOP_TYPE]:
	set(val):
		if targets != val:
			targets = val;
			emit_changed();

func get_id():
	return "AttackInfo";

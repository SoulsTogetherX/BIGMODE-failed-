@tool
class_name HealthDeltaInfo extends ResourceInfo

@export_group("Damage, Heal, and Range")
@export var delta      : int = -1:
	set(val):
		if delta != val:
			delta = val;
			emit_changed();

@export var range       : float = 500:
	set(val):
		if range != val:
			range = val;
			emit_changed();

@export_group("Target")
@export var targets : Array[ALLEGIANCE] = [ALLEGIANCE.ENEMY, ALLEGIANCE.NEUTRAL]:
	set(val):
		if targets != val:
			targets = val;
			emit_changed();

@export var target_type : SingleTargetInfo:
	set(val):
		if target_type != val:
			if target_type != null:
				target_type.changed.disconnect(emit_changed);
			if val != null:
				val.changed.connect(emit_changed);
				target_type = val;
			else:
				target_type = SingleTargetInfo.new();
				target_type.changed.connect(emit_changed);
			emit_changed();

func get_id():
	return "AttackInfo";

func _init() -> void:
	target_type = SingleTargetInfo.new();

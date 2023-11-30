@tool
class_name TroopInfo extends ResourceInfo

@export_group("Health")
@export var health  : HealthInfo:
	set(val):
		if health != val:
			if health != null:
				health.changed.disconnect(emit_changed);
			if val != null:
				val.changed.connect(emit_changed);
				health = val;
			else:
				health = HealthInfo.new();
				health.changed.connect(emit_changed);
			emit_changed();

@export_group("Attack and Heal")
@export var delta  : HealthDeltaInfo:
	set(val):
		if delta != val:
			if delta != null:
				delta.changed.disconnect(emit_changed);
			if val != null:
				val.changed.connect(emit_changed);
				delta = val;
			else:
				delta = HealthDeltaInfo.new();
				delta.changed.connect(emit_changed);
			emit_changed();

@export_group("Other")
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

func _init() -> void:
	health = HealthInfo.new();
	delta = HealthDeltaInfo.new();

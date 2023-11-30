@tool
class_name RangeInfo extends ResourceInfo

@export_group("Priority")
@export var priority : PriorityInfo:
	set(val):
		if priority != val:
			if priority != null:
				priority.changed.disconnect(emit_changed);
			if val != null:
				val.changed.connect(emit_changed);
				priority = val;
			else:
				priority = PriorityInfo.new();
				priority.changed.connect(emit_changed);
			emit_changed();

@export_group("DPS")
@export var delta : HealthDeltaInfo:
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

@export var shoot_speed : float:
	set(val):
		if shoot_speed != val:
			shoot_speed = val;
			emit_changed();

@export_group("Projectile")
@export var projectile : LinearProjectileInfo:
	set(val):
		if projectile != val:
			if val != null:
				val.changed.connect(emit_changed);
			if projectile != null:
				projectile.changed.disconnect(emit_changed);
			
			projectile = val;
			emit_changed();

@export var projectile_speed : float:
	set(val):
		if projectile_speed != val:
			projectile_speed = val;
			emit_changed();

@export_group("Random")
@export var fire_pos : ShapeInfo:
	set(val):
		if fire_pos != val:
			if fire_pos != null:
				fire_pos.changed.disconnect(emit_changed);
			if val != null:
				val.changed.connect(emit_changed);
				fire_pos = val;
			else:
				fire_pos = ShapeInfo.new();
				fire_pos.changed.connect(emit_changed);
			emit_changed();

@export var target_pos : ShapeInfo:
	set(val):
		if target_pos != val:
			if target_pos != null:
				target_pos.changed.disconnect(emit_changed);
			if val != null:
				val.changed.connect(emit_changed);
				target_pos = val;
			else:
				target_pos = ShapeInfo.new();
				target_pos.changed.connect(emit_changed);
			emit_changed();

func get_id():
	return "RangeInfo";

func _init() -> void:
	priority = PriorityInfo.new();
	delta = HealthDeltaInfo.new();
	fire_pos = ShapeInfo.new();
	target_pos = ShapeInfo.new();

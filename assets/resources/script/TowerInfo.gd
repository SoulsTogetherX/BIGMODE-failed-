@tool
class_name TowerInfo extends ResourceInfo

@export_group("Health")
@export var health : HealthInfo:
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


@export_group("Projectile")
@export var range : RangeInfo:
	set(val):
		if range != val:
			if range != null:
				range.changed.disconnect(emit_changed);
			if val != null:
				val.changed.connect(emit_changed);
				range = val;
			else:
				range = RangeInfo.new();
				range.changed.connect(emit_changed);
			emit_changed();


@export_group("Deployment")
@export var deployment : DeploymentInfo:
	set(val):
		if deployment != val:
			if deployment != null:
				deployment.changed.disconnect(emit_changed);
			if val != null:
				val.changed.connect(emit_changed);
				deployment = val;
			else:
				deployment = DeploymentInfo.new();
				deployment.changed.connect(emit_changed);
			emit_changed();


@export_group("Other")
@export var domain_range : int = 500:
	set(val):
		if domain_range != val:
			domain_range = val;
			emit_changed();

@export var weight       : int = 10:
	set(val):
		if weight != val:
			weight = val;
			emit_changed();

func get_id():
	return "TowerInfo";

func _init() -> void:
	health = HealthInfo.new();
	range = RangeInfo.new();
	deployment = DeploymentInfo.new();

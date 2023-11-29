@tool
class_name TowerInfo extends ResourceInfo

@export_group("Health")
@export var health : HealthInfo:
	set(val):
		if health != val:
			if val != null:
				val.changed.connect(emit_changed);
			if health != null:
				health.changed.disconnect(emit_changed);
			
			health = val;
			emit_changed();


@export_group("Projectile")
@export var range : RangeInfo:
	set(val):
		if range != val:
			if val != null:
				val.changed.connect(emit_changed);
			if range != null:
				range.changed.disconnect(emit_changed);
			
			range = val;
			emit_changed();


@export_group("Deployment")
@export var deployment : DeploymentInfo:
	set(val):
		if deployment != val:
			if val != null:
				val.changed.connect(emit_changed);
			if deployment != null:
				deployment.changed.disconnect(emit_changed);
			
			deployment = val;
			emit_changed();


@export_group("Other")
@export var domain_range : int:
	set(val):
		if domain_range != val:
			domain_range = val;
			emit_changed();

@export var weight       : int:
	set(val):
		if weight != val:
			weight = val;
			emit_changed();

func get_id():
	return "TowerInfo";

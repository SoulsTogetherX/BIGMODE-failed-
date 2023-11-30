@tool
class_name DeploymentInfo extends ResourceInfo

@export_group("Troop Number")
@export var max_troops : int = 5:
	set(val):
		if max_troops != val:
			max_troops = val;
			emit_changed();

@export var troop_regeneration : int = 0:
	set(val):
		if troop_regeneration != val:
			troop_regeneration = val;
			emit_changed();

@export_group("Troop")
@export var troop_info : TroopInfo:
	set(val):
		if troop_info != val:
			troop_info = val;
			emit_changed();

@export_group("Exit Position")
@export var exit_pos : ShapeInfo:
	set(val):
		if exit_pos != val:
			if exit_pos != null:
				exit_pos.changed.disconnect(emit_changed);
			if val != null:
				val.changed.connect(emit_changed);
				exit_pos = val;
			else:
				exit_pos = ShapeInfo.new();
				exit_pos.changed.connect(emit_changed);
			emit_changed();

func get_id():
	return "DeploymentInfo";

func _init() -> void:
	exit_pos = ShapeInfo.new();
	troop_info = TroopInfo.new();
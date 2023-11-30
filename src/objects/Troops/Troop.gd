@tool
class_name Troop extends CharacterBody2D

signal changeHealth(delta : int);

@onready var _resource_distributor : ResourceDistributor = $ResourceDistributor;

@export var type      : ResourceInfo.ALLEGIANCE;
@export_group("Info")
var troopInfo : TroopInfo = TroopInfo.new():
	set(val):
		if troopInfo != val:
			troopInfo = val;
			if _resource_distributor != null:
				_resource_distributor.update();

var current_effects : int = 0;

func init(resouce : TroopInfo) -> void:
	if !Engine.is_editor_hint():
		troopInfo = resouce.duplicate(true);
	else:
		troopInfo = resouce;
	
	var arg_resources : Array[ResourceInfo] = [troopInfo.health];
	_resource_distributor.init(self, arg_resources);

func is_dead() -> bool:
	return troopInfo.health.is_death();

func get_type() -> ResourceInfo.ALLEGIANCE:
	return type;

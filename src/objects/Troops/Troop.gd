@tool
class_name Troop extends CharacterBody2D

signal changeHealth(delta : int);

@onready var _resource_distributor : ResourceDistributor = $ResourceDistributor;

@export var type      : ResourceInfo.ALLEGIANCE;
@export_group("Info")
@export var troopInfo : TroopInfo:
	set(val):
		if val == null:
			troopInfo = TroopInfo.new();
			return;
		troopInfo = val;

var current_effects : int = 0;

func _init() -> void:
	if troopInfo == null:
		troopInfo = TroopInfo.new();

func _ready() -> void:
	# TESTING PURPOSES
	init(troopInfo);

func init(resouce : TroopInfo) -> void:
	troopInfo = resouce;
	
	var arg_resources : Array[ResourceInfo] = [troopInfo.health];
	_resource_distributor.init(self, arg_resources);

func get_type() -> ResourceInfo.ALLEGIANCE:
	return type;

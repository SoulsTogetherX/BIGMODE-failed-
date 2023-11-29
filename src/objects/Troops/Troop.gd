class_name Troop extends CharacterBody2D

signal changeHealth(delta : int);

@onready var _resource_distributor : ResourceDistributor = $ResourceDistributor;

@export var troopInfo : TroopInfo;

func _ready() -> void:
	# TESTING PURPOSES
	init(troopInfo);

func init(resouce : TroopInfo) -> void:
	troopInfo = resouce;
	
	var arg_resources : Array[ResourceInfo] = [troopInfo.health];
	_resource_distributor.init(self, arg_resources);

func get_type() -> ResourceInfo.ALLEGIANCE:
	return troopInfo.type;

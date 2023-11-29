@tool
class_name Tower extends Node2D

signal changeHealth(delta : int);

@onready var _resource_distributor : ResourceDistributor = $ResourceDistributor

@export var type       : ResourceInfo.ALLEGIANCE;
@export var tower_info : TowerInfo;

func _ready() -> void:
	if !Engine.is_editor_hint():
		tower_info = tower_info.duplicate(true);
	
	var arg_resources : Array[ResourceInfo] = [tower_info.range, tower_info.health, tower_info.deployment];
	_resource_distributor.init(self, arg_resources);

func get_type() -> ResourceInfo.ALLEGIANCE:
	return type;

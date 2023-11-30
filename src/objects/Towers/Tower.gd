@tool
extends Node2D

signal changeHealth(delta : int);

signal funcAllTroops(call : Callable);
signal troop_enter(troop : Troop);
signal troop_exit(troop : Troop);
signal release_troops();

@onready var _resource_distributor : ResourceDistributor = $ResourceDistributor

@export var type         : ResourceInfo.ALLEGIANCE;
@export_group("Info")
@export var tower_info   : TowerInfo:
	set(val):
		if val == null:
			tower_info = TowerInfo.new();
		else:
			tower_info = val;
		
		if _resource_distributor != null:
			_resource_distributor.update();

func _ready() -> void:
	if tower_info == null:
		if not get_parent() is Tower:
			return;
		tower_info = TowerInfo.new();
	
	if !Engine.is_editor_hint():
		tower_info = tower_info.duplicate(true);
	
	var arg_resources : Array[ResourceInfo] = [tower_info.range, tower_info.health, tower_info.deployment];
	_resource_distributor.init(self, arg_resources);

func regenerate() -> void:
	pass;

func get_type() -> ResourceInfo.ALLEGIANCE:
	return type;

func toggle_root(id : String, toggle : bool = true) -> void:
	_resource_distributor.toggle_root(id, toggle);

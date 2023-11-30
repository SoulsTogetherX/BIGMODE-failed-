@tool
class_name ResourceDistributor extends Node

var _modRoots : Dictionary;

func init(actor : Node2D, resources : Array[ResourceInfo]) -> void:
	var sorted : Dictionary = Dictionary();
	for resource in resources:
		sorted[resource.get_id()] = resource;
	
	for child in get_children():
		if child is ModRoot:
			child.init(actor, sorted[child.get_id().left(-3) + "Info"]);
			
			_modRoots[child.get_id()] = child;
			
			child.update();

func update() -> void:
	for root in _modRoots.values():
		root.update();

func toggle_root(id : String, toggle : bool = true) -> void:
	_modRoots[id].process_mode = toggle;

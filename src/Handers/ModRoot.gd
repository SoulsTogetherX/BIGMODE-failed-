@tool
class_name ModRoot extends Node

var _mods : Array[ModPart];

func init(actor : Node2D, resource : ResourceInfo) -> void:
	for child in get_children():
		if child is ModPart:
			child.init();
			
			child.actor = actor;
			child.resource = resource;
			_mods.append(child);
			
			child.update();

func update() -> void:
	for mod in _mods:
		mod.update();

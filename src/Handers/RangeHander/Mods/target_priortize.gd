@tool
extends ModPart

@export var finder : ModPart;

func get_target() -> Troop:
	return resource.priority.get_target(actor.global_position, finder.find_targets()) as Troop;

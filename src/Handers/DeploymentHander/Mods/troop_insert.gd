@tool
extends ModPart

@export var storage : ModPart;

func _actor_setter(val):
	if val != actor:
		actor = val;
		actor.troop_enter.connect(troop_insert);

func troop_insert(troop : Troop) -> void:
	
	pass;

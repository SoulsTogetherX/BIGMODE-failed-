@tool
class_name PriortizeModPart extends ModPart

@export var finder : TargetFinderModPart;

func get_target() -> Troop:
	var troops : Array[Troop] = finder.find_targets();
	if troops.is_empty():
		return null;
	
	match resource.priority:
		RangeInfo.PRIORTIZE.CLOSE:
			return _close_priority(troops);
		RangeInfo.PRIORTIZE.FAR:
			return _far_priority(troops);
		_:
			return null;

func _close_priority(troops : Array[Troop]) -> Troop:
	var closest_troop    : Troop;
	var closest_distance : float = INF;
	
	for troop in troops:
		var distance = troop.position.distance_squared_to(actor.position);
		if distance < closest_distance:
			closest_distance = distance;
			closest_troop = troop;
	
	return closest_troop;

func _far_priority(troops : Array[Troop]) -> Troop:
	var farther_troop    : Troop;
	var farther_distance : float = -INF;
	
	for troop in troops:
		var distance = troop.position.distance_squared_to(actor.position);
		if distance > farther_distance:
			farther_distance = distance;
			farther_troop = troop;
	
	return farther_troop;

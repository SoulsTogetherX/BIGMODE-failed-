@tool
class_name PriorityInfo extends ResourceInfo

const funcs : Array = ["close_priority", "far_priority", "random_priority"];
enum PRIORTIZE {CLOSE = 0, FAR = 1, RANDOM = 2};

@export var priority : PRIORTIZE = PRIORTIZE.CLOSE:
	set(val):
		if priority != val:
			priority = val;
			emit_changed();

func get_target(from : Vector2, checks : Array) -> Node2D:
	if checks.is_empty():
		return null;
	
	return call(funcs[priority], from, checks);

static func close_priority(from : Vector2, checks : Array) -> Node2D:
	var closest_node     : Node2D = null;
	var closest_distance : float = INF;

	for check in checks:
		if not check is Node2D:
			continue;
		
		var distance = check.global_position.distance_squared_to(from);
		if distance < closest_distance:
			closest_distance = distance;
			closest_node = check;

	return closest_node;

static func far_priority(from : Vector2, checks : Array) -> Node2D:
	var farest_node      : Node2D = null;
	var farther_distance : float = -INF;

	for check in checks:
		if not check is Node2D:
			continue;
		
		var distance = check.global_position.distance_squared_to(from);
		if distance > farther_distance:
			farther_distance = distance;
			farest_node = check;

	return farest_node;

static func random_priority(from : Vector2, checks : Array) -> Node2D:
	return checks.pick_random();

func get_id():
	return "PriorityInfo";

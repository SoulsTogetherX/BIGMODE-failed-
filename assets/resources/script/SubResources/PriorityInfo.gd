@tool
class_name PriorityInfo extends ResourceInfo

const funcs : Array = ["_close_priority", "_far_priority", "_random_priority"];
enum PRIORTIZE {CLOSE = 0, FAR = 1, RANDOM = 2};

@export var priority : PRIORTIZE:
	set(val):
		if priority != val:
			priority = val;
			emit_changed();

func get_target(from : Vector2, checks : Array) -> Node2D:
	if checks.is_empty():
		return null;
	
	return call(funcs[priority], from, checks);

func _close_priority(from : Vector2, checks : Array) -> Node2D:
	var closest_node     : Node2D;
	var closest_distance : float = INF;

	for check in checks:
		var distance = check.global_position.distance_squared_to(from);
		if distance < closest_distance:
			closest_distance = distance;
			closest_node = check;

	return closest_node;

func _far_priority(from : Vector2, checks : Array) -> Node2D:
	var farest_node      : Node2D;
	var farther_distance : float = -INF;

	for check in checks:
		var distance = check.global_position.distance_squared_to(from);
		if distance > farther_distance:
			farther_distance = distance;
			farest_node = check;

	return farest_node;

func _random_priority(from : Vector2, checks : Array) -> Node2D:
	return checks.pick_random();

func get_id():
	return "PriorityInfo";

class_name NavigationInfo extends Resource

enum UPDATE_TYPE     {CONSTANT, PURSE};
enum FLOW_TYPE       {RUNNING, PAUSED, LAGGING, FINISHED};
enum FORMATION_SHAPE {POINT, ORBIT, CIRCLE, SQUARE, RECTANGLE, TRIANGLE};

var _update    : UPDATE_TYPE = UPDATE_TYPE.CONSTANT;
var _flow      : FLOW_TYPE   = FLOW_TYPE.FINISHED;

var _positions : Array[Vector2];
var _group     : Array[GroupNavigation] = [];

var _formation      : FORMATION_SHAPE = FORMATION_SHAPE.POINT;
var _formation_args : Array[Variant];

var _target;
var target:
	get:
		if _update == UPDATE_TYPE.CONSTANT:
			return _target;
		else:
			return _target.global_position;
	set(val):
		if val is Node2D:
			_update = UPDATE_TYPE.PURSE;
		elif val is Vector2:
			_update = UPDATE_TYPE.CONSTANT;
		else:
			push_error("Error - NavigationInfo - attempted to set ", val, " as target. Ignoring...");
			return;
		_target = val;

func safe_target_set(target) -> bool:
	if target is Node2D:
		_update = UPDATE_TYPE.PURSE;
	elif target is Vector2:
		_update = UPDATE_TYPE.CONSTANT;
	else:
		return false;
	_target = target;
	return true;

func get_state() -> FLOW_TYPE:
	return _flow;

func size() -> int:
	return _group.size();

func is_empty() -> bool:
	return _group.is_empty();



func set_formation(formation : FORMATION_SHAPE, args : Dictionary = {}) -> void:
	_formation_args = [];
	_formation = formation;
	
	match formation:
		FORMATION_SHAPE.POINT:
			return;
		FORMATION_SHAPE.ORBIT:
			if args.has("number") && args["number"] is float:
				_formation_args.append(args["number"]);
			else:
				_formation_args.append(-1 as int);
			
			if args.has("distance") && args["distance"] is float:
				_formation_args.append(args["distance"]);
			else:
				_formation_args.append(2.5 as float);
		FORMATION_SHAPE.CIRCLE:
			if args.has("orbit_inc") && args["orbit_inc"] is float:
				_formation_args.append(args["orbit_inc"]);
			else:
				_formation_args.append(2.5 as float);
			
			if args.has("distance_inc") && args["distance_inc"] is float:
				_formation_args.append(args["distance_inc"]);
			else:
				_formation_args.append(10.0 as float);
			
			if args.has("close") && args["close"] is bool:
				_formation_args.append(args["close"]);
			else:
				_formation_args.append(false as bool);
		FORMATION_SHAPE.SQUARE:
			if args.has("x_inc") && args["x_inc"] is float:
				_formation_args.append(args["x_inc"]);
			else:
				_formation_args.append(10.0 as float);
			
			if args.has("y_inc") && args["y_inc"] is float:
				_formation_args.append(args["y_inc"]);
			else:
				_formation_args.append(10.0 as float);
		FORMATION_SHAPE.RECTANGLE:
			if args.has("x_length") && args["x_length"] is float:
				_formation_args.append(args["x_length"]);
			else:
				_formation_args.append(100.0 as float);
			
			if args.has("y_length") && args["y_length"] is float:
				_formation_args.append(args["y_length"]);
			else:
				_formation_args.append(100.0 as float);
			
			if args.has("x_num") && args["x_num"] is int:
				_formation_args.append(args["x_num"]);
			else:
				_formation_args.append(10 as int);
		FORMATION_SHAPE.TRIANGLE:
			if args.has("x_inc") && args["x_inc"] is float:
				_formation_args.append(args["x_inc"]);
			else:
				_formation_args.append(10.0 as float);
			
			if args.has("y_inc") && args["y_inc"] is float:
				_formation_args.append(args["y_inc"]);
			else:
				_formation_args.append(10.0 as float);
			
			if args.has("tip_num") && args["tip_num"] is int:
				_formation_args.append(args["tip_num"]);
			else:
				_formation_args.append(1 as int);
			
			if args.has("row_inc") && args["row_inc"] is int:
				_formation_args.append(args["row_inc"]);
			else:
				_formation_args.append(1 as int);
	
	if args.has("angle") && args["angle"] is float:
		_formation_args.append(args["angle"]);
	else:
		_formation_args.append(0.0 as float);

func set_formation_point() -> void:
	_formation = FORMATION_SHAPE.POINT;
	_formation_args = [];

func set_formation_orbit(number : int = -1, distance : float = 5.0, angle : float = 0.0) -> void:
	_formation = FORMATION_SHAPE.ORBIT;
	_formation_args = [number, distance, angle];

func set_formation_circle(orbit_inc : float = 2.5, distance_inc : float = 10.0, close : bool = false, angle : float = 0.0) -> void:
	_formation = FORMATION_SHAPE.CIRCLE;
	_formation_args = [orbit_inc, distance_inc, close, angle];

func set_formation_square(x_inc : float = 10.0, y_inc : float = 10.0, angle : float = 0.0) -> void:
	_formation = FORMATION_SHAPE.SQUARE;
	_formation_args = [x_inc, y_inc, angle];

func set_formation_rectangle(x_length : float = 100.0, y_length : float = 100.0, x_num : int = 10, angle : float = 0.0) -> void:
	_formation = FORMATION_SHAPE.RECTANGLE;
	_formation_args = [x_length, y_length, x_num, angle];

func set_formation_triangle(x_inc : float = 10.0, y_inc : float = 10.0, tip_num : int = 1, row_inc : int = 1, angle : float = 0.0) -> void:
	_formation = FORMATION_SHAPE.TRIANGLE;
	_formation_args = [x_inc, y_inc, tip_num, row_inc, angle];



func _get_positions() -> void:
	match _formation:
		FORMATION_SHAPE.POINT:
			_create_positions_point();
		FORMATION_SHAPE.ORBIT:
			if _formation_args[0] == -1:
				_positions = _create_positions_orbit(_group.size(), _formation_args[1] * (_group.size() - 1), _formation_args[2]);
			else:
				_positions = _create_positions_orbit(_formation_args[0], _formation_args[1], _formation_args[2]);
		FORMATION_SHAPE.CIRCLE:
			_create_positions_circle(_formation_args[0], _formation_args[1], _formation_args[2], _formation_args[3]);
		FORMATION_SHAPE.SQUARE:
			_create_positions_square(_formation_args[0], _formation_args[1], _formation_args[2]);
		FORMATION_SHAPE.RECTANGLE:
			_create_positions_rectangle(_formation_args[0], _formation_args[1], _formation_args[2], _formation_args[3]);
		FORMATION_SHAPE.TRIANGLE:
			_create_positions_triangle(_formation_args[0], _formation_args[1], _formation_args[2], _formation_args[3], _formation_args[4]);

func _create_positions_point() -> void:
	_positions = [];
	for n in _group.size():
		_positions.append(Vector2.ZERO);

func _create_positions_orbit(num : int, distance : float, angle_add) -> Array[Vector2]:
	var ret : Array[Vector2] = [];
	var dist : Vector2 = Vector2(0, distance);
	var angle : float = TAU / num;
	for n in num:
		ret.append(dist.rotated(angle * n + angle_add));
	
	return ret;

func _create_positions_circle(orbit_inc : float = 5, distance_inc : float = 20, close : bool = false, angle : float = 0.0) -> void:
	_positions = [Vector2.ZERO];
	var num : int = 0;
	var distance : float = 0;
	var size : int = _group.size();
	while size > 0:
		num += orbit_inc;
		size -= num;
		if close && size < 0:
			num += size;
		
		distance += distance_inc;
		_positions.append_array(_create_positions_orbit(num, distance, angle));

func _create_positions_square(x_inc : float = 20, y_inc : float = 20, angle : float = 0.0) -> void:
	_positions = [];
	var temp : float = sqrt(_group.size());
	if temp != floor(temp):
		temp = floor(temp) + 1;
	var length : int = temp;
	
	temp = -length * 0.5;
	var y : float = temp * y_inc;
	
	temp *= x_inc;
	var x : float;
	
	for r in length:
		x = temp;
		for c in length:
			_positions.append(Vector2(x, y).rotated(angle));
			x += x_inc;
		y += y_inc;

func _create_positions_rectangle(x_length : float = 100.0, y_length : float = 100.0, x_num : int = 10, angle : float = 0.0) -> void:
	_positions = [];
	var y    : float = -y_length * 0.5;
	var temp : float = -x_length * 0.5;
	var x    : float;
	
	var y_num : int = ceili(_group.size() / x_num);
	var x_inc = x_length / x_num;
	var y_inc = y_length / y_num;
	
	for r in y_num:
		x = temp;
		for c in x_num:
			_positions.append(Vector2(x, y).rotated(angle));
			x += x_inc;
		y += y_inc;

func _create_positions_triangle(x_inc : float = 10.0, y_inc : float = 10.0, tip_num : int = 1, row_inc : int = 1, angle : float = 0.0) -> void:
	_positions = [];
	var x_num : int = tip_num;
	var y_num : int = 0;
	
	var size : int = _group.size();
	while size > 0:
		y_num += 1;
		size -= x_num;
		x_num += row_inc;
	
	var x : float;
	var y : float = -y_num * 0.5 * y_inc;
	
	x_num = tip_num;
	for r in y_num:
		x = -x_num * 0.5 * x_inc;
		for c in x_num:
			_positions.append(Vector2(x, y).rotated(angle));
			x += x_inc;
		x_num += row_inc;
		y += y_inc;



func add_unit(nav_unit : GroupNavigation) -> void:
	_group.append(nav_unit);
	if _group.size() > _positions.size() || (_formation == FORMATION_SHAPE.CIRCLE && _formation_args[2]):
		_get_positions();

func remove_unit(nav_unit : GroupNavigation) -> void:
	_group.erase(nav_unit);

func add_units(nav_units : Array[GroupNavigation]) -> void:
	_group.append_array(nav_units);
	if _group.size() > _positions.size() || (_formation == FORMATION_SHAPE.CIRCLE && _formation_args[2]):
		_get_positions();

func remove_units(nav_units : Array[GroupNavigation]) -> void:
	_group.filter(_filter.bind(nav_units));

func _filter(val : Variant, nav_units : Array[GroupNavigation]) -> bool:
	return not val in nav_units;



func start() -> void:
	_get_positions();
	_flow = FLOW_TYPE.RUNNING;
	for i in _group.size():
		var unit = _group[i];
		unit._start(_target);
		unit.target_position = _target + _positions[i];

func pause() -> void:
	_flow = FLOW_TYPE.PAUSED;
	for unit in _group:
		unit._stop();

func kill() -> void:
	_flow = FLOW_TYPE.FINISHED;
	for unit in _group:
		unit._stop();
	_group = [];

func update() -> void:
	if _flow != FLOW_TYPE.RUNNING:
		return;
	
	for nav_unit in _group:
		nav_unit.target_position = nav_unit.target_position;

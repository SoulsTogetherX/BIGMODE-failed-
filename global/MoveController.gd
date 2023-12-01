extends Node

const DEFAULT_DELAY    : float = 0.5;
const DEFAULT_LAG      : float = 0.5;
const DEFAULT_DISTANCE : int   = 1;

var _GROUPS       : Array[NavigationInfo] = [];
var _UNUSED_IDS   : Array[int] = [];
var _GROUP_ACCESS : Dictionary = {}; 
	# GroupNavigation -> int(0, ...)

var _timer : Timer;
var _formation_shape : NavigationInfo.FORMATION_SHAPE = NavigationInfo.FORMATION_SHAPE.POINT;
var _formation_args  : Dictionary = {};

var check_distance : int = DEFAULT_DISTANCE;
var auto_stop : bool = false;

func _ready() -> void:
	_timer = Timer.new();
	_timer.wait_time = DEFAULT_DELAY
	_timer.timeout.connect(update_all);
	
	add_child(_timer);
	_timer.start();

func set_delay(delay : float = DEFAULT_DELAY) -> void:
	_timer.wait_time = delay;

func set_check_distance(check_distance : int = DEFAULT_DELAY) -> void:
	self.check_distance = check_distance;

func set_auto_stop(auto_stop : bool = false) -> void:
	self.auto_stop = auto_stop;

func set_formation(formation_shape : NavigationInfo.FORMATION_SHAPE, formation_args : Dictionary = {}) -> void:
	_formation_shape = formation_shape;
	_formation_args = formation_args;



func add_to_acces(nav_unit : GroupNavigation) -> void:
	_GROUP_ACCESS[nav_unit] = -1;

func remove_from_access(nav_unit : GroupNavigation) -> void:
	_GROUP_ACCESS.erase(nav_unit);

func is_moving(nav_unit : GroupNavigation) -> bool:
	var idx = _GROUP_ACCESS[nav_unit];
	if idx != -1:
		return _GROUPS[idx].get_state() == NavigationInfo.FLOW_TYPE.RUNNING;
	
	return false;

func is_paused(nav_unit : GroupNavigation) -> bool:
	var idx = _GROUP_ACCESS[nav_unit];
	if idx != -1:
		return _GROUPS[idx].get_state() == NavigationInfo.FLOW_TYPE.PAUSED;
	
	return false;



func move_unit(nav_unit : GroupNavigation, target) -> bool:
	if not (target is Node2D || target is Vector2):
		return false;
	_remove_unit(nav_unit);
	
	var idx = _get_available_idx();
	
	var nav_info : NavigationInfo = _GROUPS[idx];
	nav_info.target = target;
	nav_info.add_unit(nav_unit);
	
	_GROUP_ACCESS[nav_unit] = idx;
	nav_unit.target_position = nav_info.target;
	
	nav_info.start();
	
	return true;

func _remove_unit(nav_unit : GroupNavigation) -> void:
	var idx : int = _GROUP_ACCESS[nav_unit];
	if idx == -1:
		return;
	
	_GROUPS[idx].remove_unit(nav_unit);
	if _GROUPS[idx].is_empty():
		_GROUPS[idx].kill();
		_insert_available_idx(idx);

func move_group(nav_units : Array[GroupNavigation], target) -> bool:
	var nav_info : NavigationInfo = _move_group(nav_units, target);
	if nav_info == null:
		return false;
	
	nav_info.set_formation(_formation_shape, _formation_args);
	nav_info.start();
	
	return true;

func move_group_formation(nav_units : Array[GroupNavigation], target, formation : NavigationInfo.FORMATION_SHAPE, args : Dictionary = {}) -> bool:
	var nav_info : NavigationInfo = _move_group(nav_units, target);
	if nav_info == null:
		return false;
	
	nav_info.set_formation(formation, args);
	nav_info.start();
	
	return true;

func _move_group(nav_units : Array[GroupNavigation], target) -> NavigationInfo:
	if not (target is Node2D || target is Vector2):
		return null;
	_remove_units(nav_units);
	
	var idx = _get_available_idx();
	
	var nav_info : NavigationInfo = _GROUPS[idx];
	nav_info.target = target;
	nav_info.add_units(nav_units);
	
	for nav_unit in nav_units:
		_GROUP_ACCESS[nav_unit] = idx;
		nav_unit.target_position = nav_info.target;
		
	return nav_info;

func _remove_units(nav_units : Array[GroupNavigation]) -> void:
	for nav_unit in nav_units:
		_remove_unit(nav_unit);


func update_all() -> void:
	for group in _GROUPS:
		group.update();



func _insert_available_idx(idx : int) -> void:
	_UNUSED_IDS.insert(_UNUSED_IDS.bsearch_custom(idx, _reverse_sort, false), idx);

func _reverse_sort(c1 : Variant, c2 : Variant) -> bool:
	return c1 >= c2;

func _get_available_idx() -> int:
	if _UNUSED_IDS.is_empty():
		_GROUPS.append(NavigationInfo.new());
		return _GROUPS.size() - 1;
	else:
		return _UNUSED_IDS.pop_back();

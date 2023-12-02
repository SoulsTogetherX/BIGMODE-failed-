class_name GroupNavigation extends NavigationAgent2D

signal stopped_moving;
signal start_moving(target);

var _is_moving : bool = false;

@export var _actor : Node2D;
@export var auto_stop : bool = true;
@export var stop_check_distance : int = 1;


func _enter_tree() -> void:
	MoveController.add_to_acces(self);

func _exit_tree() -> void:
	MoveController.remove_from_access(self);

func is_moving() -> bool:
	return _is_moving;

func get_actor_position() -> Vector2:
	return _actor.global_position;

func stop() -> void:
	_is_moving = false;
	stopped_moving.emit();
	#MoveController.stop_unit_group(self)

func _stop() -> void:
	_is_moving = false;
	stopped_moving.emit();

func start(target) -> void:
	if MoveController.move_unit(self, target):
		start_moving.emit(target);
		_is_moving = true;

func _start(target) -> void:
	start_moving.emit(target);
	_is_moving = true;

func get_velocity_simple(spd : float) -> Vector2:
	if _is_moving:
		if auto_stop && check_for_stop():
			stop();
		else:
			return _actor.to_local(get_next_path_position()).normalized() * spd;
	return Vector2.ZERO;

func get_avoidence_velocity(spd : float) -> Vector2:
	if _is_moving:
		if auto_stop && check_for_stop():
			stop();
		else:
			velocity = _actor.to_local(get_next_path_position()).normalized() * spd;
			return await velocity_computed;
	return Vector2.ZERO;

func check_for_stop() -> bool:
	return int(get_next_path_position().distance_to(_actor.global_position)) <= stop_check_distance;

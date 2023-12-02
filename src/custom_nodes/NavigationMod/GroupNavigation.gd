class_name GroupNavigation extends NavigationAgent2D

signal stopped_moving;
signal start_moving(target);

var _is_moving : bool = false;

@export var actor : Node2D;
@export var auto_stop : bool = true;

func _enter_tree() -> void:
	MoveController.add_to_acces(self);

func _exit_tree() -> void:
	MoveController.remove_from_access(self);

func is_moving() -> bool:
	return _is_moving;

func get_actor_position() -> Vector2:
	return actor.global_position;

func stop() -> void:
	_is_moving = false;
	stopped_moving.emit();

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
			return actor.to_local(get_next_path_position()).normalized() * spd;
	return Vector2.ZERO;

func get_avoidence_velocity(spd : float) -> void:
	if _is_moving:
		if auto_stop && check_for_stop():
			stop();
		else:
			velocity = actor.to_local(get_next_path_position()).normalized() * spd;

func check_for_stop() -> bool:
	return get_final_position().distance_to(actor.global_position) <= path_desired_distance;

func _on_velocity_computed(safe_velocity: Vector2) -> void:
	actor.velocity = safe_velocity;
	actor.do_move();

extends State

@export var _idle : State;

func get_id():
	return "slow_down";

func state_ready() -> void:
	pass;

func enter() -> void:
	pass;

func exit() -> void:
	pass;

func process_input(_event: InputEvent) -> State:
	return null;

func process_physics(delta: float) -> State:
	print(_actor.velocity)
	_actor.velocity.move_toward(Vector2.ZERO, 1000);
	if _actor.velocity.is_zero_approx():
		return _idle;
	
	_actor.do_move();
	return null;

func process_frame(_delta: float) -> State:
	return null;

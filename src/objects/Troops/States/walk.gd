extends State
func get_id():
	return "walk";

func state_ready() -> void:
	pass;

func enter() -> void:
	pass;

func exit() -> void:
	pass;

func process_input(_event: InputEvent) -> State:
	return null;

func process_physics(_delta: float) -> State:
	_actor.velocity = _actor.get_move_AI_simple();
	_actor.move_and_slide();
	return null;

func process_frame(_delta: float) -> State:
	return null;

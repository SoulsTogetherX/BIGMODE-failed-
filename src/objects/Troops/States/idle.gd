extends State

func get_id():
	return "idle";

func state_ready() -> void:
	pass;

func enter() -> void:
	_actor.toggle_nav(false);

func exit() -> void:
	_actor.toggle_nav(true);

func process_input(_event: InputEvent) -> State:
	return null;

func process_physics(_delta: float) -> State:
	return null;

func process_frame(_delta: float) -> State:
	return null;

extends State

func get_id():
	return "select_tile";

func state_ready() -> void:
	pass;

func enter() -> void:
	pass;

func exit() -> void:
	pass;

func draw() -> void:
	pass;

func process_input(_event: InputEvent) -> State:
	return null;

func process_physics(delta: float) -> State:
	if Input.is_action_just_pressed("select"):
		_actor.draw_tile();
	return null;

func process_frame(_delta: float) -> State:
	return null;

extends State

func get_id():
	return "fly";

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
	var movement : Vector2 = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized() * _actor.SPEED;
	_actor.move_position(delta, movement);
	return null;

func process_frame(_delta: float) -> State:
	return null;

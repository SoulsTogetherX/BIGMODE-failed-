extends State

@export var _idle : State;

var _stopped : bool;

func get_id():
	return "walk";

func state_ready() -> void:
	pass;

func enter() -> void:
	_actor.get_node("AnimationPlayer").play("walking");
	_stopped = false;

func exit() -> void:
	pass;

func process_input(_event: InputEvent) -> State:
	return null;

func process_physics(_delta: float) -> State:
	_actor.velocity = await _actor.get_move_AI_avoidence();
	_actor.do_move();
	return null;

func process_frame(_delta: float) -> State:
	if _stopped:
		return _idle;
	
	return null;

func _on_nav_mod_stopped_moving() -> void:
	_stopped = true;

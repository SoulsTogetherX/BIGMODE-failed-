extends State

@export var _idle : State;

var animate : AnimationPlayer;
var _stopped : bool;

func get_id():
	return "walk";

func state_ready() -> void:
	animate = _actor.get_node("AnimationPlayer");

func enter() -> void:
	animate.play("walking");
	animate.advance(randf() * 0.8);
	_stopped = false;

func exit() -> void:
	pass;

func process_input(_event: InputEvent) -> State:
	return null;

func process_physics(_delta: float) -> State:
	_actor.do_move_AI_avoidence();
	return null;

func process_frame(_delta: float) -> State:
	if _stopped:
		return _idle;
	
	return null;

func _on_nav_mod_stopped_moving() -> void:
	_stopped = true;

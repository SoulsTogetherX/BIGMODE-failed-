extends State

@export var _walk : State;

var animate : AnimationPlayer;
var _walking : bool;

func get_id():
	return "idle";

func state_ready() -> void:
	animate = _actor.get_node("AnimationPlayer");

func enter() -> void:
	animate.play("idle");
	_walking = false;

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null;

func process_physics(_delta: float) -> State:
	return null;

func process_frame(_delta: float) -> State:
	if _walking:
		return _walk;
	return null;

func _on_nav_mod_start_moving(_target) -> void:
	_walking = true;

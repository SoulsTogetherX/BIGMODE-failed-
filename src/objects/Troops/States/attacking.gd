extends State

@export var _idle : State;

var target;

var animate : AnimationPlayer;
var _attacking : bool

func get_id():
	return "attacking";

func state_ready() -> void:
	animate = _actor.get_node("AnimationPlayer");
	animate.animation_finished.connect(_attacking_ended);

func enter() -> void:
	animate.play("attacking");
	_attacking = true;
	await get_tree().create_timer(0.6).timeout;
	var delta : HealthDeltaInfo = _actor.troopInfo.delta;
	delta.target_type.affect_health(target, delta.delta, delta.targets);

func exit() -> void:
	pass;

func process_input(_event: InputEvent) -> State:
	return null;

func process_physics(_delta: float) -> State:
	return null;

func process_frame(_delta: float) -> State:
	if !_attacking:
		return _idle;
	
	return null;

func _attacking_ended(anim_name : StringName) -> void:
	_attacking = false;

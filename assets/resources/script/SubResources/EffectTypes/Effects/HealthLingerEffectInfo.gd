@tool
class_name HealthLingerEffectInfo extends BlankEffectInfo

@export var time : float:
	set(val):
		time = val;
		emit_changed();

@export var particle : PackedScene:
	set(val):
		particle = val;
		emit_changed();

@export var delta    : int:
	set(val):
		delta = val;
		emit_changed();

@export var delay    : float:
	set(val):
		delay = val;
		emit_changed();

func trigger_effect(actor : Node2D) -> void:
	if (actor.current_effects & EFFECT_TYPE.BURN) > 0:
		return;
	actor.current_effects |= EFFECT_TYPE.BURN;
	
	if particle:
		actor.add_child(particle.instantiate());
	
	var caller = RepeatCaller.new();
	caller.interval = time;
	caller.delay = delay;
	caller.autostart = true;
	caller.end_func = _linger_func(actor);
	caller.call_func = _linger_func.bind(actor, delta);
	actor.add_child(caller);

func _linger_func(actor : Node2D) -> Callable:
	return (func(change : Signal, delta : int):
			change.emit(delta);\
		).bind(actor.changeHealth, delta);

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
	var caller = RepeatCaller.new();
	caller.interval = time;
	caller.delay = delay;
	caller.autostart = true;
	caller.end_func = (
		func(caller : RepeatCaller):
			caller.queue_free;\
		).bind(caller);
	caller.call_func = (
		func(change : Signal, delta : int):
			change.emit(delta);\
		).bind(actor.changeHealth, delta);
	
	if particle:
		caller.add_child(particle.instantiate());
	actor.add_child(caller);

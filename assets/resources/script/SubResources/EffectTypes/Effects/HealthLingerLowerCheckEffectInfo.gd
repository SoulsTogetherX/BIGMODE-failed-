@tool
class_name HealthLingerLowerCheckEffectInfo extends HealthLingerEffectInfo

@export var min_val : float:
	set(val):
		min_val = val;
		emit_changed();

func _linger_func(actor : Node2D) -> Callable:
	return (func(change : Signal, delta : int, check : Callable):
			if check.call() > min_val:
				change.emit(delta);\
		).bind(actor.changeHealth, delta, actor.get_health);

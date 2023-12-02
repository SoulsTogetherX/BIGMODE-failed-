@tool
class_name HealthLingerPercentageLowerCheckEffectInfo extends HealthLingerLowerCheckEffectInfo

func _linger_func(actor : Node2D) -> Callable:
	return (func(change : Signal, delta : int, check : Callable):
			if check.call() > min_val:
				change.emit(delta);\
		).bind(actor.changeHealth, delta, actor.get_health_percent);

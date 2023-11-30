@tool
extends ModPart

@export var onDeath : ModPart;
@export var onHit   : ModPart;
@export var onHeal  : ModPart;

func _resource_setter(val):
	if resource != val:
		if resource != null:
			resource.changed.disconnect(update);
		if val != null:
			val.changed.connect(update);
			val.recover_all_health();
		resource = val;

func health_change(delta : int) -> void:
	match resource.health_change(delta):
		HealthInfo.HEALTH_SIGNAL.HEALED:
			onHeal.execute_action();
		HealthInfo.HEALTH_SIGNAL.REVIVED:
			onHeal.execute_action();
		HealthInfo.HEALTH_SIGNAL.DAMAGED:
			onHit.execute_action();
		HealthInfo.HEALTH_SIGNAL.KILLED:
			onDeath.execute_action();

@tool
extends ModPart

@export var onDeath : ModPart;
@export var onHit   : ModPart;
@export var onHeal  : ModPart;

var health : int = -1;

func _resource_setter(val):
	if resource != val:
		if resource != null:
			resource.changed.disconnect(update);
		if val != null:
			val.changed.connect(update);
			health = val.max_health;
		resource = val;

func update() -> void:
	health = min(health, resource.max_health);

func health_change(delta : int) -> void:
	var change = clamp((health + delta), 0, resource.max_health);
	if change == health:
		return;
	
	if delta > 0:
		print("heal");
		onHeal.execute_action();
	else:
		if change == 0:
			print("death");
			onDeath.execute_action();
		else:
			print("hit");
			onHit.execute_action();
	
	health = change;

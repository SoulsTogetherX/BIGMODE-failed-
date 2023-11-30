@tool
class_name SingleTargetInfo extends ResourceInfo

@export var effect : BlankEffectInfo:
	set(val):
		if effect != val:
			if val != null:
				val.changed.connect(emit_changed);
			if effect != null:
				effect.changed.disconnect(emit_changed);
			
			effect = val;
			emit_changed();

func get_id():
	return "AttackTypeInfo";

func _affect_troop(target : Troop, delta : int, target_types : Array[ALLEGIANCE]):
	target.changeHealth.emit(delta);

func _affect_tower(target : Tower, delta : int, target_types : Array[ALLEGIANCE]):
	target.changeHealth.emit(delta);

func affect_health(target : Node2D, delta : int, target_types : Array[ALLEGIANCE] = []) -> void:
	if target is Troop:
		_affect_troop(target, delta, target_types);
	elif target is Tower:
		_affect_tower(target, delta, target_types);
	
	if effect:
		effect.trigger_effect(target);

@tool
class_name SingleTargetInfo extends ResourceInfo

var _shape : CircleShape2D;

func _init() -> void:
	_shape = CircleShape2D.new();
	_shape.radius = 5;

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

func _affect_dissipate(target : Node2D, delta : int, target_types : Array[ALLEGIANCE]):
	var physics : PhysicsDirectSpaceState2D = target.get_world_2d().direct_space_state;
	var query = PhysicsShapeQueryParameters2D.new();
	query.set_shape(_shape);
	query.collision_mask = 6;
	query.transform = Transform2D(0, Vector2(1.,1.), 0, target.global_position);
	var results = physics.intersect_shape(query);
	
	PriorityInfo.close_priority(target.global_position, results).changeHealth.emit(delta);

func affect_health(target : Node2D, delta : int, target_types : Array[ALLEGIANCE] = [], notFound : bool = false) -> void:
	if notFound:
		_affect_dissipate(target, delta, target_types);
	
	if target is Troop:
		_affect_troop(target, delta, target_types);
	elif target is Tower:
		_affect_tower(target, delta, target_types);
	
	if effect:
		effect.trigger_effect(target);

@tool
class_name SpreadTargetInfo extends SingleTargetInfo

@export var radius : float = 5:
	get:
		return _shape.radius;
	set(val):
		_shape.radius = val;
		emit_changed();

func _affect_troop(target : Troop, delta : int, target_types : Array[ALLEGIANCE]):
	var physics : PhysicsDirectSpaceState2D = target.get_world_2d().direct_space_state;
	var query = PhysicsShapeQueryParameters2D.new();
	query.set_shape(_shape);
	query.collision_mask = 4;
	query.transform = Transform2D(0, Vector2(1.,1.), 0, target.global_position);
	var results = physics.intersect_shape(query);
	
	for c in results:
		var collide = c.collider;
		if collide.get_type() in target_types:
			if collide is Troop:
				collide.changeHealth.emit(delta);
			elif collide is Tower:
				_affect_tower(collide, delta, target_types);

func _affect_tower(target : Tower, delta : int, target_types : Array[ALLEGIANCE]):
	target.changeHealth.emit(delta);

func _affect_dissipate(target : Node2D, delta : int, target_types : Array[ALLEGIANCE]):
	var physics : PhysicsDirectSpaceState2D = target.get_world_2d().direct_space_state;
	var query = PhysicsShapeQueryParameters2D.new();
	query.set_shape(_shape);
	query.collision_mask = 6;
	query.transform = Transform2D(0, Vector2(1.,1.), 0, target.global_position);
	var results = physics.intersect_shape(query);
	
	for c in results:
		var collide = c.collider;
		if collide.get_type() in target_types:
			if collide is Troop:
				collide.changeHealth.emit(delta);
			elif collide is Tower:
				_affect_tower(collide, delta, target_types);

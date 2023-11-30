class_name LinearProjectileInfo extends ResourceInfo

@export var continous_collition_checking : bool = false;
@export var projectile : PackedScene:
	set(val):
		if projectile != val:
			projectile = val;
			emit_changed();

func spawn(
		parent    : Node,
		delta     : HealthDeltaInfo,
		spd       : float,
		start_pos : Vector2,
		target    : Vector2 = Vector2.ZERO,
		) -> Node2D:
	assert(projectile != null, "ERROR - Attempted to spawn projectile of type NULL.");
	
	var new_pos = (target - start_pos).normalized() * delta.range + start_pos;
	
	var proj : Projectile = projectile.instantiate();
	assert(proj != null, "ERROR - Attempted to spawn a Node that isn't a Projectile.");
	
	parent.add_child(proj);
	proj.global_rotation = start_pos.angle_to(new_pos);
	proj.global_position = start_pos;
	
	var tw = proj.create_tween();
	tw.tween_property(proj, "global_position", new_pos, spd);
	tw.tween_callback(proj.on_dissipate);

	proj._movement = tw;
	proj._deltaType = delta;
	proj.continous_collition_checking = continous_collition_checking;
	
	return proj;

class_name ArcProjectileInfo extends LinearProjectileInfo

@export var arc_height : float = 200:
	set(val):
		if val != arc_height:
			arc_height = val;
			emit_changed();

func spawn(
		parent    : Node,
		delta     : HealthDeltaInfo,
		spd       : float,
		start_pos : Vector2,
		target    : Vector2 = Vector2.ZERO,
		) -> Node2D:
	assert(projectile != null, "ERROR - Attempted to spawn projectile of type NULL.");
	
	var start   : Vector2 = start_pos;
	var end     : Vector2 = target;
	var control : Vector2 = start + ((end - start) * 0.5) + (Vector2.UP * arc_height);
	
	var proj : Projectile = projectile.instantiate();
	assert(proj != null, "ERROR - Attempted to spawn a Node that isn't a Projectile.");
	
	parent.add_child(proj);
	proj.global_position = start_pos;
	
	var tw = proj.create_tween();
	tw.tween_method(_arc_shoot.bind(proj, start, control, end), 0.0, 1.0, spd);
	tw.tween_callback(proj.on_dissipate);
	
	proj._movement = tw;
	proj._deltaType = delta;
	
	return proj;

func _arc_shoot(gradient : float, projectile : Node2D, start : Vector2, control : Vector2, end : Vector2) -> void:
	var lerp1   : Vector2 = lerp(start, control, gradient);
	var lerp2   : Vector2 = lerp(control, end, gradient);
	var new_pos : Vector2 = lerp(lerp1, lerp2, gradient);
	projectile.global_rotation = projectile.global_position.angle_to(new_pos);
	projectile.global_position = new_pos;

@tool
extends ModPart

@export var priortize : ModPart;

var _cooldown : Timer;

func init() -> void:
	_cooldown = Timer.new();
	add_child(_cooldown);
	_cooldown.stop();
	if !Engine.is_editor_hint():
		_cooldown.timeout.connect(_on_cooldown);

func update() -> void:
	if !Engine.is_editor_hint():
		_cooldown.wait_time = resource.shoot_speed;
		_cooldown.start();

func shoot_at(target : Vector2) -> void:
	var projectile = resource.projectile.instantiate();
	var attack = resource.delta;
	
	get_tree().root.add_child(projectile);
	projectile.global_position = actor.global_position;
	
	projectile.settup_projectile(
		resource.delta,
		resource.projectile_speed,
		target
	);

func _on_cooldown() -> void:
	var target : Troop = priortize.get_target();
	if target == null:
		return;
	
	var random : float = min(resource.shoot_speed * 0.1, 0.1);
	await get_tree().create_timer(randf_range(0, random)).timeout;
	shoot_at(target.global_position);
	
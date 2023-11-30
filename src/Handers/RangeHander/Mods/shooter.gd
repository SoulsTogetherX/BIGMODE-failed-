@tool
extends ModPart

@export var priortize : ModPart;
@export var random    : ModPart;

var _cooldown : Timer;
var on_burst : bool = false;

func init() -> void:
	_cooldown = Timer.new();
	add_child(_cooldown);
	_cooldown.stop();
	if !Engine.is_editor_hint():
		_cooldown.timeout.connect(_on_cooldown);

func update() -> void:
	if !Engine.is_editor_hint():
		_cooldown.wait_time = resource.shoot_speed * 0.5;
		_cooldown.start();

func _shoot_at(target : Vector2) -> void:
	var projectile = resource.projectile.spawn(
		get_tree().root,
		resource.delta,
		resource.projectile_speed,
		random.get_begin(),
		random.get_end(target),
	);

func _on_cooldown() -> void:
	var target : Troop = priortize.get_target();
	if target == null || resource.projectile == null:
		return;
	
	var burst : int = ceili(resource.scatter * resource.burst);
	if on_burst:
		burst = resource.scatter - burst;
	on_burst = !on_burst;
	
	var random : float = min(resource.shoot_speed * 0.1, 0.1);
	await get_tree().create_timer(randf_range(0, random)).timeout;
	
	burst -= 1;
	for i in burst:
		_shoot_at(target.global_position);
		target = priortize.get_target();
		if target == null:
			return;
	_shoot_at(target.global_position);
	

class_name Projectile extends Node2D

@onready var _detector : Area2D = $CollisionDetection;

var _deltaType     : HealthDeltaInfo;
var _speed         : float;
var _target_vec    : Vector2;

var _traveled      : float = 0;

func settup_projectile(
			delta   : HealthDeltaInfo,
			spd     : float,
			target  : Vector2 = Vector2.ZERO) -> void:
	_deltaType     = delta;
	_speed         = spd;
	_target_vec    = (target - global_position).normalized();

func destroy() -> void:
	queue_free();

func on_collide() -> void:
	destroy();

func on_dissipate() -> void:
	destroy();

func move_frame(delta : float) -> void:
	var distance = _target_vec * _speed * delta;
	position += distance;
	_find_collitions();
	_distance_update(Vector2.ZERO.distance_to(distance));

func _physics_process(delta : float) -> void:
	move_frame(delta);

func _find_collitions() -> void:
	for collide in _detector.get_overlapping_bodies():
		if collide.get_type() in _deltaType.targets:
			_deltaType.target_type.affect_health(collide, _deltaType.delta, _deltaType.targets);
			on_collide();

func _distance_update(distance : float) -> void:
	_traveled += distance;
	if _traveled > _deltaType.range:
		on_dissipate();

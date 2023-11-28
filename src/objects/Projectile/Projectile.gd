class_name Projectile extends Node2D

var _attackType    : AttackInfo;
var _vaild_targets : Array[Troop.TROOP_TYPE];

var _speed         : float;
var _move_range    : float;
var _target_vec    : Vector2;

var _traveled      : float = 0;

func settup_projectile(
			attack  : AttackInfo,
			targets : Array[Troop.TROOP_TYPE],
			range   : float,
			spd     : float,
			target  : Vector2 = Vector2.ZERO) -> void:
	_attackType    = attack;
	_vaild_targets = targets;
	_move_range    = range;
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
	pass;

func _distance_update(distance : float) -> void:
	_traveled += distance;
	if _traveled > _move_range:
		on_dissipate();

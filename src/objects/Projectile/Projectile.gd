class_name Projectile extends Node2D

@onready var _detector : Area2D = $CollisionDetection;
@onready var _particle : ParticleClear = $particle;

@export var continous_collition_checking : bool = false:
	set(val):
		continous_collition_checking = val;
		set_physics_process(continous_collition_checking);

var _deltaType     : HealthDeltaInfo;
var _movement      : Tween;

func _ready() -> void:
	set_physics_process(continous_collition_checking);

func destroy(fade_particle : bool = true) -> void:
	if fade_particle && _particle:
		_particle.fade_this();
	queue_free();

func on_collide() -> void:
	destroy();

func on_dissipate() -> void:
	destroy();
	if !_find_collitions():
		_deltaType.target_type.affect_health(self, _deltaType.delta, _deltaType.targets, true);

func _physics_process(delta : float) -> void:
	_find_collitions();

func _find_collitions() -> bool:
	for collide in _detector.get_overlapping_bodies():
		if collide.get_type() in _deltaType.targets && !collide.is_dead():
			_deltaType.target_type.affect_health(collide, _deltaType.delta, _deltaType.targets);
			on_collide();
			return true;
	return false;

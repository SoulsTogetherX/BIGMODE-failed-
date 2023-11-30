class_name Projectile extends Node2D

@onready var _detector : Area2D = $CollisionDetection;
@onready var _particle : ParticleClear = $particle;

var _deltaType     : HealthDeltaInfo;
var _movement      : Tween;

func destroy(fade_particle : bool = true) -> void:
	if fade_particle && _particle:
		_particle.fade_this();
	queue_free();

func on_collide() -> void:
	destroy();

func on_dissipate() -> void:
	destroy();

func _physics_process(delta : float) -> void:
	_find_collitions();

func _find_collitions() -> void:
	for collide in _detector.get_overlapping_bodies():
		if collide.get_type() in _deltaType.targets:
			_deltaType.target_type.affect_health(collide, _deltaType.delta, _deltaType.targets);
			on_collide();

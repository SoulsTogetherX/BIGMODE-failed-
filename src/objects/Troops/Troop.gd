@tool
class_name Troop extends CharacterBody2D

signal changeHealth(delta : int);

@onready var _resource_distributor : ResourceDistributor = $ResourceDistributor;
@onready var _nav_unit             : GroupNavigation     = $nav_mod;
@onready var _sprite               : Sprite2D            = $sprite_sheet;

@export var type      : ResourceInfo.ALLEGIANCE;
@export_group("Info")
var troopInfo : TroopInfo = TroopInfo.new():
	set(val):
		if troopInfo != val:
			troopInfo = val;
			if _resource_distributor != null:
				_resource_distributor.update();

var current_effects : int = 0;

func init(resouce : TroopInfo) -> void:
	if !Engine.is_editor_hint():
		troopInfo = resouce.duplicate(true);
	else:
		troopInfo = resouce;
	
	var arg_resources : Array[ResourceInfo] = [troopInfo.health];
	
	if _resource_distributor == null:
		await ready;
	_resource_distributor.init(self, arg_resources);
	
	_nav_unit.max_speed = troopInfo.move_speed;

func do_move() -> void:
	if velocity.x < 0:
		_sprite.flip_h = true;
	elif velocity.x > 0:
		_sprite.flip_h = false;
	var min_velocity = max(velocity.length() * 0.5, 0.01);
	move_and_slide();
	if velocity.length() < min_velocity && velocity.length() != 0:
		_nav_unit.stop();

func is_dead() -> bool:
	return troopInfo.health.is_death();

func get_type() -> ResourceInfo.ALLEGIANCE:
	return type;

func get_move_AI_simple() -> Vector2:
	return _nav_unit.get_velocity_simple(troopInfo.move_speed);

func do_move_AI_avoidence() -> void:
	_nav_unit.call_deferred("get_avoidence_velocity", troopInfo.move_speed);

func get_health() -> int:
	return troopInfo.health.current_health;

func get_health_percent() -> int:
	return troopInfo.health.get_health_ratio();

func attack(target) -> void:
	$StateOverhead/StateMachine/attacking.target = target;
	$StateOverhead.change_state("attacking", "main");

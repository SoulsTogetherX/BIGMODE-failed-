@tool
extends ModPart
			
var _detection  : Area2D = null;
var _collide    : CollisionShape2D = null;
var _drawCaller : DrawCaller = null;

func _actor_setter(val):
	if actor != val:
		actor = val;
		if _detection.get_parent():
			_detection.get_parent().remove_child(_detection);
		actor.add_child(_detection);
		_reposition();
	else:
		_collide.disabled = true;
		if _detection.get_parent():
			_detection.get_parent().remove_child(_detection);

func _create_detection() -> void:
	_detection = Area2D.new();
	_detection.collision_layer = 0;
	_detection.collision_mask  = 4;
	
	_collide   = CollisionShape2D.new();
	_collide.shape = CircleShape2D.new();
	_collide.disabled = true;
	
	_detection.add_child(_collide);

func _reposition() -> void:
	if actor == null:
		return;
	
	_detection.position = Vector2.ZERO;
	_collide.disabled = false;

func _set_range() -> void:
	_collide.shape.radius = resource.delta.range;

func init() -> void:
	_create_detection();

func update() -> void:
	_set_range();

func find_targets() -> Array[Troop]:
	if actor == null:
		return [];
	
	var troops : Array[Troop];
	for troop in _detection.get_overlapping_bodies():
		if troop.get_type() in resource.delta.targets:
			troops.append(troop);
	return troops;

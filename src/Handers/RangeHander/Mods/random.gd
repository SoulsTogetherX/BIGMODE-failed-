@tool
extends ModPart

@export var draw_mod : Node2D;

var begin_random : ShapeInfo;
var end_random   : ShapeInfo;

func _resource_setter(val):
	if resource != val:
		if resource != null:
			begin_random.changed.disconnect(update);
			end_random.changed.disconnect(update);
		if val != null:
			begin_random = val.fire_pos;
			begin_random.changed.connect(update);
			
			end_random = val.target_pos;
			end_random.changed.connect(update);
		resource = val;

func update() -> void:
	if Engine.is_editor_hint():
		
		draw_mod.draw_this(end_random.get_draw_func.bind(Color("#ffa50040")));
		draw_mod.draw_this(begin_random.get_draw_func.bind(Color("#a020f040")));

func get_begin() -> Vector2:
	return begin_random.get_random_point() + actor.global_position;

func get_end(target : Vector2) -> Vector2:
	return end_random.get_random_point() + target;

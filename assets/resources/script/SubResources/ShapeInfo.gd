@tool
class_name ShapeInfo extends ResourceInfo

enum EMISSION_SHAPE {POINT = 0, CIRCLE = 1, RECTANGLE = 2};

const DEFAUT_COLOR : Color = Color("#dc143c80");

@export var offset : Vector2:
	set(val):
		if val != offset:
			offset = val;
			emit_changed();

@export var shape : EMISSION_SHAPE:
	set(val):
		if val != shape:
			shape = val;
			emit_changed();
			notify_property_list_changed();

var gizmo_extents : float = 10:
	set(val):
		if val != gizmo_extents:
			gizmo_extents = val;
			emit_changed();

var radius : float = 0.01:
	set(val):
		if val != radius:
			radius = val;
			emit_changed();

var rect  : Rect2;
var width : float = 0.01:
	get:
		return rect.size.x;
	set(val):
		if val != width:
			rect.position.x = -val * 0.5;
			rect.size.x = val;
			emit_changed();
var height : float = 0.01:
	get:
		return rect.size.y;
	set(val):
		if val != height:
			rect.position.y = -val * 0.5;
			rect.size.y = val;
			emit_changed();

func _get_property_list():
	var properties = [];
	match shape:
		EMISSION_SHAPE.POINT:
			properties.append({
				name  = "gizmo_extents",
				type  = TYPE_FLOAT,
				hint  = PROPERTY_HINT_RANGE,
				hint_string = "0,1000,0.5",
				usage = PROPERTY_USAGE_DEFAULT,
			});
		EMISSION_SHAPE.CIRCLE:
			properties.append({
				name  = "radius",
				type  = TYPE_FLOAT,
				hint  = PROPERTY_HINT_RANGE,
				hint_string = "0.01,1000,0.01",
				usage = PROPERTY_USAGE_DEFAULT,
			});
		EMISSION_SHAPE.RECTANGLE:
			properties.append({
				name  = "width",
				type  = TYPE_FLOAT,
				hint  = PROPERTY_HINT_RANGE,
				hint_string = "0.01,2000,0.01",
				usage = PROPERTY_USAGE_DEFAULT,
			});
			properties.append({
				name  = "height",
				type  = TYPE_FLOAT,
				hint  = PROPERTY_HINT_RANGE,
				hint_string = "0.01,2000,0.01",
				usage = PROPERTY_USAGE_DEFAULT,
			});
	return properties;

func get_random_point() -> Vector2:
	match shape:
		EMISSION_SHAPE.POINT:
			return offset;
		EMISSION_SHAPE.CIRCLE:
			return offset + Vector2(0, randf() * radius).rotated(randf_range(0, TAU));
		EMISSION_SHAPE.RECTANGLE:
			return offset + rect.position + (rect.size * Vector2(randf(), randf()));
	return Vector2.ZERO;

func get_draw_func(drawer : Node2D, draw_color : Color = DEFAUT_COLOR) -> void:
	match shape:
		EMISSION_SHAPE.POINT:
			drawer.draw_circle(offset, 0.1, draw_color);
			var gizmo_end = Vector2(gizmo_extents * 0.5, 0);
			drawer.draw_line(offset - gizmo_end, offset + gizmo_end, draw_color, 3);
			gizmo_end = Vector2(0, gizmo_extents * 0.5);
			drawer.draw_line(offset - gizmo_end, offset + gizmo_end, draw_color, 3)
		EMISSION_SHAPE.CIRCLE:
			drawer.draw_circle(offset, radius, draw_color);
		EMISSION_SHAPE.RECTANGLE:
			var draw_rect : Rect2 = rect;
			draw_rect.position += offset;
			drawer.draw_rect(draw_rect, draw_color);

func get_id():
	return "ShapeInfo";

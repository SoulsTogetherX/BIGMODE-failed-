class_name GridController extends Node2D

const GIRD_SIZE : Vector2i = Vector2i(64, 64);

func _ready() -> void:
	global_position = Vector2.ZERO;

var _doDraw : bool = false;
var _draw_at : Vector2i;
func _draw() -> void:
	if _doDraw:
		draw_rect(get_rect_at_tile(_draw_at), Color.CYAN);

func get_tile_at(position : Vector2) -> Vector2i:
	return Vector2i(floor(position.x / GIRD_SIZE.x), floor(position.y / GIRD_SIZE.y));

func get_rect_at_tile(tile : Vector2i) -> Rect2i:
	return Rect2i(tile * GIRD_SIZE, GIRD_SIZE);

func get_center_at_tile(tile : Vector2i) -> Vector2:
	return ((tile * GIRD_SIZE) as Vector2) + (GIRD_SIZE * 0.5);

func clear_draw() -> void:
	_doDraw = false;
	queue_redraw();

func draw_tile_at(tile : Vector2i) -> void:
	_doDraw = true;
	_draw_at = tile;
	queue_redraw();

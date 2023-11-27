class_name GridControl extends Node

const GRID_SIZE : Vector2i   = Vector2i(64, 64);
var   WORLD     : Dictionary = Dictionary(); # Vector2i   -> Array[GridObject]
var   POS_INFO  : Dictionary = Dictionary(); # GridObject -> Vector2i

func get_tile_at(position : Vector2) -> Vector2i:
	return Vector2i(floor(position.x / GRID_SIZE.x), floor(position.y / GRID_SIZE.y));

func get_rect_at_tile(tile : Vector2i) -> Rect2i:
	return Rect2i(tile * GRID_SIZE, GRID_SIZE);

func get_center_at_tile(tile : Vector2i) -> Vector2:
	return ((tile * GRID_SIZE) as Vector2) + (GRID_SIZE * 0.5);

func add_to_tile(obj : GridObject, tile : Vector2i) -> void:
	if WORLD.has(tile):
		WORLD[tile].append(obj);
		return;
	WORLD[tile] = [obj];

func tile_has(obj : GridObject, tile : Vector2i) -> bool:
	return WORLD.has(tile) && WORLD[tile].has(obj);

func remove_from_tile(obj : GridObject, tile : Vector2i) -> GridObject:
	if WORLD.has(tile):
		WORLD[tile].erase(obj);
		return obj;
	return null;

func get_all_from_tile(tile : Vector2i) -> Array[GridObject]:
	if WORLD.has(tile):
		return WORLD[tile].values();
	return [];

func clear_tile(tile : Vector2i) -> Array[GridObject]:
	if WORLD.has(tile):
		var ret = WORLD[tile].values();
		WORLD[tile].clear();
		return ret;
	return [];

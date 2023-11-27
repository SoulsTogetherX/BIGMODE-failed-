class_name GridControl extends Node

const      GRID_SIZE : Vector2i   = Vector2i(64, 64);
static var WORLD     : Dictionary = {}; # Vector2i   -> Array[GridObject]
static var POS_INFO  : Dictionary = {}; # GridObject -> Vector2i

static func get_tile_at(position : Vector2) -> Vector2i:
	return Vector2i(floor(position.x / GRID_SIZE.x), floor(position.y / GRID_SIZE.y));

static func get_rect_at_tile(tile : Vector2i) -> Rect2i:
	return Rect2i(tile * GRID_SIZE, GRID_SIZE);

static func get_center_at_tile(tile : Vector2i) -> Vector2:
	return ((tile * GRID_SIZE) as Vector2) + (GRID_SIZE * 0.5);

static func add_to_tile(obj : GridObject, tile : Vector2i) -> void:
	if WORLD.has(tile):
		WORLD[tile].append(obj);
		POS_INFO[obj] = tile;
		return;
	WORLD[tile] = [obj];

static func add_to_tile_exclusive(obj : GridObject, tile : Vector2i) -> bool:
	if WORLD.has(tile) || WORLD[tile] == []:
		WORLD[tile].append(obj);
		POS_INFO[obj] = tile;
		return true;
	return false;

static func tile_has(obj : GridObject, tile : Vector2i) -> bool:
	return POS_INFO.has(obj) && POS_INFO[obj] == tile;

static func remove_from_tile(obj : GridObject, tile : Vector2i) -> GridObject:
	if WORLD.has(tile):
		WORLD[tile].erase(obj);
		POS_INFO.erase(obj);
		return obj;
	return null;

static func get_all_from_tile(tile : Vector2i) -> Array[GridObject]:
	if WORLD.has(tile):
		return WORLD[tile];
	return [];

static func tile_empty(tile : Vector2i) -> bool:
	return !WORLD.has(tile) || WORLD[tile].is_empty();

static func tile_size(tile : Vector2i) -> int:
	if !WORLD.has(tile):
		return 0;
	return WORLD[tile].size();

static func clear_tile(tile : Vector2i) -> Array[GridObject]:
	if WORLD.has(tile):
		var ret = WORLD[tile];
		for obj in ret:
			POS_INFO.erase(obj);
		WORLD[tile].clear();
		return ret;
	return [];

static func get_position(obj : GridObject) -> Vector2i:
	return POS_INFO[obj];

@tool
class_name GridObject extends Node2D

var _grid_position : Vector2i = Vector2i(0, 0);
@export var grid_position : Vector2i = Vector2i(0, 0):
	get:
		return _grid_position;
	set(val):
		_set_position(val);

@export var snap_runtime : bool = false;

func _notification(what):
	match what:
		NOTIFICATION_TRANSFORM_CHANGED:
			_set_position(GridControl.get_tile_at(global_position));

func _set_position(pos : Vector2i) -> void:
	set_notify_transform(false);
	if Engine.is_editor_hint():
		_grid_position = pos;
		_reset_position();
		set_notify_transform(true);
		return;
	
	if pos != _grid_position:
		GridControl.remove_from_tile(self, _grid_position);
		_grid_position = pos;
		GridControl.add_to_tile(self, _grid_position);
	
	_reset_position();
	set_notify_transform(true);

func _reset_position() -> void:
	set_notify_transform(false);
	global_position = GridControl.get_center_at_tile(_grid_position);
	set_notify_transform(true);

func _ready() -> void:
	_reset_position();
	
	if snap_runtime || Engine.is_editor_hint():
		set_notify_transform(true);

func adjust_size(texture : Texture2D) -> void:
	scale = (GridControl.GRID_SIZE as Vector2) / texture.get_size();

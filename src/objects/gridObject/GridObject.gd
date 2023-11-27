@tool
class_name GridObject extends Node2D

# HOTFIX tool scripts cannot compile if they use singletons
@onready var GridContr : GridControl;

var _grid_position : Vector2i = Vector2i(0, 0);
@export var grid_position : Vector2i = Vector2i(0, 0):
	get:
		return _grid_position;
	set(val):
		if !GridContr:
			GridContr = GridControl.new();
		_set_position(val);

func _notification(what):
	match what:
		NOTIFICATION_TRANSFORM_CHANGED:
			_grid_position = GridContr.get_tile_at(global_position);
			set_notify_transform(false);
			global_position = GridContr.get_center_at_tile(_grid_position);
			set_notify_transform(true);

func _set_position(pos : Vector2i) -> void:
	GridContr.remove_from_tile(self, _grid_position);
	_grid_position = pos;
	global_position = GridContr.get_center_at_tile(_grid_position);
	GridContr.add_to_tile(self, _grid_position);

func _ready() -> void:
	if !GridContr:
		GridContr = GridControl.new();
	
	_set_position(_grid_position);
	set_notify_transform(true);

func adjust_size(texture : Texture2D) -> void:
	scale = (GridContr.GRID_SIZE as Vector2) / texture.get_size();

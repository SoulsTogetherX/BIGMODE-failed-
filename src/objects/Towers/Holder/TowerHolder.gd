@tool
class_name TowerHolder extends GridObject

var _held_tower    : Tower;

@export var type   : ResourceInfo.ALLEGIANCE;
@export var _tower : PackedScene:
	set(val):
		if val == null:
			_tower = null;
			if _held_tower == null:
				return;
			_held_tower.queue_free();
			return;
		var check = val.instantiate();
		if check is Tower:
			_held_tower = check;
			add_child(_held_tower);
			_held_tower.global_position = global_position;
			_held_tower.get_node("main").flip_h = _sprite_turn;
			_tower = val;
		else:
			check.queue_free()
			_tower = null;
		
@export var _sprite_turn   : bool = false:
	set(val):
		if _held_tower:
			_held_tower.get_node("main").flip_h = val;
		_sprite_turn = val;

func _ready() -> void:
	super();
	_held_tower.global_position = global_position;



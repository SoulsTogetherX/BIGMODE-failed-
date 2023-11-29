@tool
class_name TowerMovement extends GridObject

@onready var _main_sprite : Sprite2D = $main;

func _ready() -> void:
	super();
	adjust_size(_main_sprite);

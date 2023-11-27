@tool
class_name Tower extends GridObject

@onready var texture = $main.texture;

func _ready() -> void:
	super();
	adjust_size(texture);

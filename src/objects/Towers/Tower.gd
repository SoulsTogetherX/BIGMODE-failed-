@tool
class_name Tower extends GridObject

@onready var _texture              : Texture2D           = $main.texture;
@onready var _resource_distributor : ResourceDistributor = $ResourceDistributor

@export var tower_info : TowerInfo;

func _ready() -> void:
	super();
	
	adjust_size(_texture);
	if !Engine.is_editor_hint():
		tower_info = tower_info.duplicate(true);
	
	var arg_resources : Array[ResourceInfo] = [tower_info.range, tower_info.health, tower_info.deployment];
	_resource_distributor.init(self, arg_resources);

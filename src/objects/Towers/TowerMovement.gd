@tool
class_name Tower extends GridObject

@onready var _main_sprite : Sprite2D = $main;
@onready var tower        : Node2D   = $Tower_Dummy;

signal changeHealth(delta : int);

var current_effects : int = 0;

func _ready() -> void:
	super();
	adjust_size(_main_sprite);
	
	changeHealth.connect(
		func(delta : int):
			tower.changeHealth.emit(delta);
	);

func set_attack_priority(priority : PriorityInfo.PRIORTIZE) -> void:
	tower.tower_info.range.priority.priority = priority;

func set_allegiance(type : ResourceInfo.ALLEGIANCE) -> void:
	tower.type = type;

func toggle_firing(toggle : bool = true) -> void:
	tower.toggle_root("RangeMod", toggle);

func act_on_troops(foo : Callable) -> void:
	pass;

func enter(troop : Troop) -> bool:
	return false;

func release_troops() -> void:
	pass;

func regenerate() -> void:
	pass;

func get_type() -> ResourceInfo.ALLEGIANCE:
	return tower.get_type();

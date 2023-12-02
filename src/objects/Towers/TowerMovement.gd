@tool
class_name Tower extends GridObject

@onready var main_sprite : Sprite2D = $main;
@onready var tower       : Node2D   = $Tower_Dummy;

signal changeHealth(delta : int);

var current_effects : int = 0;

func _ready() -> void:
	super();
	print("hello")
	adjust_size(main_sprite);
	
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
	tower.funcAllTroops.emit(foo);

func enter(troop : Troop) -> bool:
	return false;

func release_troops() -> void:
	pass;

func regenerate() -> void:
	pass;

func get_health() -> int:
	return tower.tower_info.health.current_health;

func get_health_percent() -> int:
	return tower.tower_info.health.get_health_ratio();

func get_type() -> ResourceInfo.ALLEGIANCE:
	return tower.get_type();

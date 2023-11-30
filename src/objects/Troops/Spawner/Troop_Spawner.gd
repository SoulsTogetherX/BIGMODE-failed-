@tool
extends GridObject

@export var type      : ResourceInfo.ALLEGIANCE;

@export_group("Info")
@export var troop_info : TroopInfo:
	set(val):
		if val == null:
			troop_info = TroopInfo.new();
			return;
		
		troop_info = val;

@export_group("Spawning")
@export var spawn_shape : ShapeInfo:
	set(val):
		if spawn_shape != null:
			spawn_shape.changed.disconnect(queue_redraw);
		
		if val == null:
			spawn_shape = ShapeInfo.new();
		else:
			spawn_shape = val;
		
		spawn_shape.changed.connect(queue_redraw);

@export var spawn_on_startup : bool = true;

var _caller : RepeatCaller;
@export var number : int = 1:
	set(val):
		number = max(val, 1);
@export var continous : bool = false:
	set(val):
		if val != continous:
			if _caller != null:
				_caller.start();
			continous = val;
			notify_property_list_changed();
var delay : float = 0:
	set(val):
		if val != delay:
			if _caller != null:
				_caller.delay = delay;
			delay = val;

func _get_property_list():
	var properties = [];
	if continous:
		properties.append({
			name  = "delay",
			type  = TYPE_FLOAT,
			hint  = PROPERTY_HINT_RANGE,
			hint_string = "0,100,0.01",
			usage = PROPERTY_USAGE_DEFAULT,
		});
	return properties;

func _draw() -> void:
	if Engine.is_editor_hint() && spawn_shape != null:
		spawn_shape.get_draw_func(self);

func _ready() -> void:
	super();
	call_deferred("_tree_ready");
	
	_caller = RepeatCaller.new();
	if !Engine.is_editor_hint():
		_caller.delay = delay;
		_caller.call_func = spawn_troops;
		_caller.interval = -1;
		_caller.autostart = true;
	add_child(_caller)

func _tree_ready() -> void:
	if get_tree().edited_scene_root == self:
		return;
	if troop_info == null:
		troop_info = TroopInfo.new();
	if spawn_shape == null:
		spawn_shape = ShapeInfo.new();
	if Engine.is_editor_hint():
		return;
	
	if spawn_on_startup:
		spawn_troops();

static var troop = preload("res://src/objects/Troops/Dummy_Troop.tscn");
func spawn_troops() -> void:
	var instance : Troop;
	
	for i in number:
		instance = troop.instantiate();
		get_tree().current_scene.add_child(instance);
		instance.owner = get_tree().current_scene;
		instance.global_position = spawn_shape.get_random_point() + global_position;
		instance.type = type;
		instance.init(troop_info);

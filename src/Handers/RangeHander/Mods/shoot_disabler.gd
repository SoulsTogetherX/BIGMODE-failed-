@tool
extends ModPart

@export var finder      : ModPart;
@export var shooter     : ModPart;
@export var check_delay : float:
	set(val):
		check_delay = val;
		if _check_delay != null:
			_check_delay.wait_time = check_delay;

var _check_delay : Timer;

func init() -> void:
	_check_delay = Timer.new();
	add_child(_check_delay);
	_check_delay.stop();
	if !Engine.is_editor_hint():
		_check_delay.timeout.connect(_on_check);
		_check_delay.wait_time = check_delay;
		_check_delay.start();

func _on_check() -> void:
	if finder.find_targets().size() > 0:
		shooter.process_mode = Node.PROCESS_MODE_INHERIT;
	else:
		shooter.process_mode = Node.PROCESS_MODE_DISABLED;

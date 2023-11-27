class_name PlayerController extends Node

enum MODE {MAKE = 0, OFFENSE = 1, DEFENCE = 2, ENHANCE = 3};

@export var _modes : Array[StateOverhead];
var _mode : MODE = MODE.MAKE;

func _ready() -> void:
	_modes[_mode].process_mode = Node.PROCESS_MODE_INHERIT;

func change_state(newMode : MODE) -> void:
	_modes[_mode].process_mode = Node.PROCESS_MODE_DISABLED;
	_modes[newMode].process_mode = Node.PROCESS_MODE_INHERIT;

func get_current_mode() -> MODE:
	return _mode;

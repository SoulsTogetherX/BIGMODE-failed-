@tool
class_name StateOverhead extends Node

## All Attached [StateMachine] objects. Each one will be Initialized and run by this [StateOverhead] object.
@export var state_machines : Array[StateMachine];

@export_group("Actor")
## Checks if this [StateOverhead] object affects a given object.[br][br]
##
## [b]Note[/b]: Changing this value mid-game execution does nothing.
@export var _usesActor : bool = false:
	set(val):
		_usesActor = val;
		notify_property_list_changed();
## The actor that will give assigned to every [State]. Typically a [CharacterBody2D] or [CharacterBody3D].[br][br]
##
## Shown in the editor window when [member _usesActor] is [code]true[/code].
var _actor;

func _get_property_list():
	var properties = [];
	if _usesActor:
		properties.append({
			name  = "_actor",
			type  = TYPE_OBJECT,
			hint  = PROPERTY_HINT_NODE_TYPE,
			usage = PROPERTY_USAGE_DEFAULT,
		});
	return properties;

func _ready() -> void:
	if Engine.is_editor_hint():
		set_process_unhandled_input(false);
		set_physics_process(false);
		set_process(false);
		return;
	
	if !_usesActor:
		_actor = null;
	elif _actor == null:
		_actor.ready;
	
	for idx in state_machines.size():
		var machine = state_machines[idx];
		machine.init(_actor, self, idx);

func _unhandled_input(event: InputEvent) -> void:
	for machine in state_machines:
		if machine:
			machine.process_input(event);

func _physics_process(delta: float) -> void:
	for machine in state_machines:
		if machine:
			machine.process_physics(delta);

func _process(delta: float) -> void:
	for machine in state_machines:
		if machine:
			machine.process_frame(delta);

## Returns the defined acting object of this [StateOverhead] object.
func get_actor() -> Node:
	return _actor;

## Changes the running [State] to an accessible one, within the [StateMachine] corresponding to
## the given index, with the given name identifier.[br][br]
##
## [b]NOTE[/b]: This function will [i]stop the program[/i] if the given name identifier cannot be
## found in the accessible children.
func change_state(state_name: String, idx: int = 0) -> void:
	state_machines[idx].change_state(state_name);

## Checks if the runnig [State]'s name identifier is withing a passed [Array] of [String] objects.
func compair_state_names(stateNames: Array[String], idx: int) -> bool:
	return state_machines[idx].current_state.get_state_name() in stateNames;

## Checks if the runnig [State]'s name identifier is equal to a passed [String] object.
func compair_state_name(stateName: String, idx: int) -> bool:
	return state_machines[idx].current_state.get_state_name() == stateName;

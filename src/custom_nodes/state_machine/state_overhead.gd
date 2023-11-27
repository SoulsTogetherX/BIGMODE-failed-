@tool
class_name StateOverhead extends Node

## Checks if this [StateOverhead] object affects a given object.[br][br]
##
## [b]Note[/b]: Changing this value during runtime does nothing.
@export var _usesActor : bool = false:
	set(val):
		_usesActor = val;
		notify_property_list_changed();
## The actor that will give assigned to every [State]. Typically a [CharacterBody2D] or [CharacterBody3D].[br][br]
##
## Shown in the editor window when [member _usesActor] is [code]true[/code].
var _actor;
var _drawMod;
var _state_machines : Dictionary;

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
	
	for machine in get_children():
		if machine is StateMachine:
			if machine.get_id() == "":
				machine._name_id = "blank";
			
			if _state_machines.has(machine.get_id()):
				machine._name_id = _make_id_unique(machine.get_id());
				_state_machines[_make_id_unique(machine.get_id())] = machine;
			else:
				_state_machines[machine.get_id()] = machine;
			
			machine.init(_actor, self);

func _make_id_unique(id : String) -> String:
	id += "_";
	var idx = 0;
	while(_state_machines.has(id + str(idx))):
		idx += 1;
	return id + str(idx);

func _unhandled_input(event: InputEvent) -> void:
	for machine in _state_machines.values():
		if machine:
			machine.process_input(event);

func _physics_process(delta: float) -> void:
	for machine in _state_machines.values():
		if machine:
			machine.process_physics(delta);

func _process(delta: float) -> void:
	for machine in _state_machines.values():
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
func change_state(state_name: String, machine_id: String) -> void:
	if _state_machines.has(machine_id):
		_state_machines[machine_id].change_state(state_name);

## Checks if the runnig [State]'s name identifier is withing a passed [Array] of [String] objects.
func compair_state_names(stateNames: Array[String], machine_id: String) -> bool:
	if _state_machines.has(machine_id):
		return _state_machines[machine_id].current_state.get_state_name() in stateNames;
	return false;

## Checks if the runnig [State]'s name identifier is equal to a passed [String] object.
func compair_state_name(stateName: String, machine_id: String) -> bool:
	if _state_machines.has(machine_id):
		return _state_machines[machine_id].current_state.get_state_name() == stateName;
	return false;

## Returns the ids of all attached [StateMachine] objects.
func get_machine_ids() -> Array[String]:
	return _state_machines.keys();

## Returns a Dictionary, with the ids of all attached [StateMachine] objects as the keys,
## and an [Array] of the ids of each corresponding [StateMachine]'s [State] objects.
func get_state_ids() -> Dictionary:
	var ret = Dictionary();
	for machine_id in _state_machines.keys():
		ret[machine_id] = _state_machines[machine_id].get_state_ids();
	return ret;

## Checks to see if this [StateOverhead] has an attached [StateMachine] with the given id.
func has_machine(machine_id : String) -> bool:
	return machine_id in _state_machines.keys();

## Checks to see if this [StateOverhead] has a [State], with the given id, attached to
## one of the attached [StateMachine] objects.
func has_state(state_id : String) -> bool:
	for machine in _state_machines.values():
		if state_id in machine.get_state_ids():
			return true;
	return false;

## Returns the id of the first [StateMachine] with a [State] with the given id.[br]
## Is there are no such [StateMachine] objects, this method will return an empty
## [String].
func find_state(state_id : String) -> String:
	for machine_id in _state_machines.keys():
		if state_id in _state_machines[machine_id].get_state_ids():
			return machine_id;
	return "";

## Checks to see if this [StateOverhead] has a [State], with the given id, attached to
## a [StateMachine] object, with the given id.
func has_machine_state(machine_id : String, state_id : String) -> bool:
	return true;

## The holder and runner of all attached [State] objects.[br]
## To use, add [State] objects as children to this [Node],
## set the [member starting_state] as once of the children [State] objects,
## and then attach this [StateMachine] to a [StateOverhead] object.
class_name StateMachine extends Node

## The name of the current [StateMachine]. This is an unique name identifier so
## this [StateMachine] may be found and utilized in an externel setting.[br][br]
##
## [b]NOTE[/b]: If this id is the same as another [StateMachine]'s in the same
## [StateOverhead], the id may be changed to be unique. If left empty, the
## value will default to [code]"blank"[/code].
@export_placeholder("Machine ID") var _name_id : String;

## The first [State] this [StateMachine] will run on initialization.[br][br]
##
## [b]NOTE[/b]: A [StateMachine] is initialized by an attached [StateOverhead] object.
@export var starting_state : State;
var _current_state         : State;
var _states                : Array[State];

# Initializes this [StateMachine] by giving each attached child [State] a reference
# to the actor object it belongs to, then enters the default [member starting_state].
func init(actor : Node, stateOverhead : StateOverhead) -> void:
	for child in get_children():
		if child is State:
			child.actor = actor;
			child.stateOverhead = stateOverhead;
			child.machine_id = _name_id;
			_states.append(child);
			
			child.state_ready();

	# Initialize to the default state
	if actor:
		await actor.ready;
	
	assert(starting_state in _states, "ERROR - StateMachine:init - Cannot find starting_state in any of this node's children");
	_change_state(starting_state);

## Calls [method State.process_input] on the running [State] in similar usage as
## [member Node._unhandled_input].
func process_input(event: InputEvent) -> void:
	var new_state = _current_state.process_input(event);
	if new_state:
		_change_state(new_state);

## Calls [method State.process_physics] on the running [State] in similar usage as
## [member Node._physics_process].
func process_physics(delta: float) -> void:
	var new_state = _current_state.process_physics(delta);
	if new_state:
		_change_state(new_state);

## Calls [method State.process_frame] on the running [State] in similar usage as
## [member Node._process].
func process_frame(delta: float) -> void:
	var new_state = _current_state.process_frame(delta);
	if new_state:
		_change_state(new_state);

func _change_state(new_state: State) -> void:
	if _current_state:
		_current_state.exit();
	
	_current_state = new_state;
	_current_state.enter();

## Changes the running [State] to an accessible one with the given name identifier.[br]
## First calls any exit logic on the current state, then the enter logic of the new
## state.[br][br]
##
## [b]NOTE[/b]: This function will [i]stop the program[/i] if the given name identifier
## cannot be found in the accessible children.
func change_state(new_state_name: String) -> void:
	var new_state = null;
	for state in _states:
		if state.get_state_name() == new_state_name:
			new_state = state;
			break;
	assert(new_state != null, "ERROR: given state_name cannot be found in state array.");

	if _current_state:
		_current_state.exit();

	_current_state = new_state;
	_current_state.enter();

## Returns this [StateMachine] object's name identifier.
func get_id() -> String:
	return _name_id;

## Returns the ids of all attached [State] objects.
func get_state_ids() -> Array[String]:
	var ret : Array[String] = [];
	for state in _states:
		ret.append(state.get_state_id());
	return ret;

## Checks to see if this [StateMachine] has an attached [State] with the given id.
func has_state(state_id : String) -> bool:
	return state_id in get_state_ids();

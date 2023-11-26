## The holder and runner of all attached [State] objects.[br]
## To use, add [State] objects as children to this [Node],
## set the [member starting_state] as once of the children [State] objects,
## and then attach this [StateMachine] to a [StateOverhead] object.
class_name StateMachine extends Node

@export var _name_id       : String = "";
## The first [State] this [StateMachine] will run on initialization.[br][br]
##
## [b]NOTE[/b]: A [StateMachine] is initialized by an attached [StateOverhead] object.
@export var starting_state : State;
var _current_state         : State;
var _states                : Array[State];

# Initializes this [StateMachine] by giving each attached child [State] a reference
# to the actor object it belongs to, then enters the default [member starting_state].
func init(actor : Node, stateOverhead : StateOverhead, machineIdx : int) -> void:
	for child in get_children():
		child.actor = actor;
		child.stateOverhead = stateOverhead;
		child.machineIdx = machineIdx;
		_states.append(child);
		
		child.state_ready();

	# Initialize to the default state
	if actor:
		await actor.ready;
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

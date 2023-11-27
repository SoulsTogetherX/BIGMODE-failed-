@tool
extends CameraFollow2D

@export var gridController : GridController;

const SPEED = 100;

@onready var player_controller: Node = $PlayerController;

func _ready() -> void:
	player_controller.change_state(PlayerController.MODE.MAKE);

func move_position(delta : float, change : Vector2) -> void:
	update_position_pos(delta, position + change);

func draw_tile() -> void:
	gridController.draw_tile_at(gridController.get_tile_at(get_global_mouse_position()));

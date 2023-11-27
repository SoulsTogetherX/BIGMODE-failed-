@tool
extends CameraFollow2D

const SPEED = 100;

@onready var mode_controller: PlayerController = $mode_controller

func _ready() -> void:
	mode_controller.change_state(PlayerController.MODE.MAKE);

func move_position(delta : float, change : Vector2) -> void:
	update_position_pos(delta, position + change);

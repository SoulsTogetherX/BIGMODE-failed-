@tool
extends CameraFollow2D

const SPEED = 100;

func _ready() -> void:
	if Engine.is_editor_hint():
		set_physics_process(false);
	
	

func move_position(delta : float, change : Vector2) -> void:
	update_position_pos(delta, position + change);

func _physics_process(delta: float) -> void:
	var movement : Vector2 = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized() * SPEED;
	move_position(delta, movement);

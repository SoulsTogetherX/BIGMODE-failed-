@tool
extends Node2D

@export var tower_info  : TowerInfo;
@onready var tower_base : Tower = $Tower_Base;

func _ready() -> void:
	if !Engine.is_editor_hint():
		tower_info = tower_info.duplicate(true);
	tower_base.init(tower_info);

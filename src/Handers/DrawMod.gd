@tool
extends Node2D

var draw_funcs : Array[Callable] = [];

func _draw() -> void:
	for foo in draw_funcs:
		foo.call(self);

func draw_this(foo : Callable) -> void:
	draw_funcs.append(foo);
	queue_redraw();

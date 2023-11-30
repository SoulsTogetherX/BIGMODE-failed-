class_name DrawCaller extends Node2D

var drawFunction : Callable = (func(): return);

func _draw() -> void:
	drawFunction.call();

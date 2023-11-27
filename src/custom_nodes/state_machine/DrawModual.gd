class_name DrawModual extends Node2D

var _drawMachines : Array;

func _draw() -> void:
	for machine in _drawMachines:
		machine.draw();

func draw(machines : Array) -> void:
	_drawMachines = machines;
	queue_redraw();

@tool
extends ModPart

func init() -> void:
	pass

func update() -> void:
	pass;

func execute_action() -> void:
	$"../../../AnimationPlayer".play("ded");
	await $"../../../AnimationPlayer".animation_finished;
	actor.queue_free();

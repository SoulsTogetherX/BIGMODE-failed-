@tool
extends ModPart

func init() -> void:
	pass

func update() -> void:
	pass;

func execute_action() -> void:
	var tw : Tween = create_tween();
	tw.set_trans(Tween.TRANS_SINE);
	tw.tween_property(actor, "modulate", Color.GREEN_YELLOW, 0.1);
	tw.tween_property(actor, "modulate", Color.WHITE, 0.1);

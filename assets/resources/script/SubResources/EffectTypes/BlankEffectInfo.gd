@tool
class_name BlankEffectInfo extends ResourceInfo

enum EFFECT_TYPE {BURN = 1, FREEZE = 2, POISON = 4, MAGIC = 8};

@export var effect_type : EFFECT_TYPE = EFFECT_TYPE.BURN;

func trigger_effect(actor : Node2D) -> void:
	pass;

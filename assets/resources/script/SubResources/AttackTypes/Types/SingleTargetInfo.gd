@tool
class_name SingleTargetInfo extends BlankTargetInfo

func _affect_troop(target : Troop, delta : int, target_types : Array[ALLEGIANCE]):
	target.changeHealth.emit(delta);

func _affect_tower(target : Tower, delta : int, target_types : Array[ALLEGIANCE]):
	target.changeHealth.emit(delta);

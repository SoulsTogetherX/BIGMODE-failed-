@tool
extends ModPart

var troops : Array[Troop] = [];

func set_troops(reinforcements : Array[Troop]) -> void:
	for t in troops:
		t.queue_free();
	troops = reinforcements;
	print(troops)

func get_troops() -> Array[Troop]:
	return troops;

func pop_troop() -> Troop:
	return troops.pop_back();

func remove_troop(troop : Troop) -> void:
	troops.erase(troop);

func push_troop(troop : Troop) -> void:
	troops.append(troop);

func push_troops(reinforcements : Array[Troop]) -> void:
	troops.append_array(reinforcements);

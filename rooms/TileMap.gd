extends TileMap

var GridSize = 4
var Dict = {}

func _ready():
	# Prints out the desired tiles from layer 0 with a indentified string as desired
	for x in GridSize:
		for y in GridSize:
			Dict[str(Vector2(x,y))] = {
					"Type": "Ground",
					"Position": str(Vector2(x,y))
			}
			set_cell(0, Vector2(x, y), 0, Vector2i(0, 0), 0)

func _process(delta):
	var tile = local_to_map(get_global_mouse_position())
	
	# Removes layer 1 tiles when the mouse isn't there
	for x in GridSize:
		for y in GridSize:
			erase_cell(1, Vector2(x,y))
	
	# Otherwise we print the layer 1 tile to show that a tile is selected
	if Dict.has(str(tile)):
		set_cell(1, tile, 1, Vector2i(0,0), 0)
		# print(Dict[str(tile)])

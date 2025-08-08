extends Node2D
class_name MapLayer

@onready var ground_layer: TileMapLayer = $Ground
@onready var decoration_layer: TileMapLayer = $Decoration
@onready var crop_layer: TileMapLayer = $Crop
@onready var road_layer: TileMapLayer = $Road
@onready var object_layer: TileMapLayer = $Object
@onready var building_layer: TileMapLayer = $Building

var soil_terrain_set: int = 0
var soil_terrain_index: int = 3
var soil_cells: Array[Vector2i] = []

func tilling() -> void:
	var player: Player = Groups.player
	if not player:
		return
	var player_position = player.global_position
	var cell_coords: Vector2i = ground_layer.local_to_map(to_local(player_position))
	var target_coords: Vector2i = cell_coords + player.direction
	if not soil_cells.has(target_coords):
		soil_cells.append(target_coords)
	
	print(soil_cells)
	ground_layer.set_cells_terrain_connect(soil_cells, soil_terrain_set, soil_terrain_index, false)

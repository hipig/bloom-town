extends Node2D
class_name MapLayer

@onready var ground_layer: TileMapLayer = $Ground
@onready var decoration_layer: TileMapLayer = $Decoration
@onready var object_layer: TileMapLayer = $Object
@onready var road_layer: TileMapLayer = $Road
@onready var building_layer: TileMapLayer = $Building
@onready var crop_layer: TileMapLayer = $Crop

var dirt_terrain_set: int = 1
var dirt_terrain_index: int = 0

var dirt_cells: Array[Vector2i] = []

func tilling() -> void:
	var player: Player = Groups.player
	if not player:
		return
	var player_position = player.global_position
	var cell_coords: Vector2i = ground_layer.local_to_map(to_local(player_position))
	var target_coords: Vector2i = cell_coords + player.direction
	decoration_layer.erase_cell(target_coords)
	dirt_cells.append(target_coords)
	
	object_layer.set_cells_terrain_connect(dirt_cells, dirt_terrain_set, dirt_terrain_index, false)

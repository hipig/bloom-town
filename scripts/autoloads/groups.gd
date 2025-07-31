extends Node

const MAP_LAYER = "map_layer"

const PLAYER: String = "player"

var player: Player: get = get_player

var map_layer: MapLayer: get = get_map_layer

func get_player() -> Player:
	return get_tree().get_first_node_in_group(PLAYER) as Player

func get_map_layer() -> MapLayer:
	return get_tree().get_first_node_in_group(MAP_LAYER) as MapLayer

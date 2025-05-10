extends Node

const scene_game = preload("res://scene/game.tscn")
const scene_gameworld = preload("res://scene/gameworld.tscn")

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"game":
			scene_to_load = scene_game
		"gameworld":
			scene_to_load = scene_gameworld
			
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)

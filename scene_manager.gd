class_name SceneManage
extends Node

var player : Player

var scene_path = "res://scene/"

func change_scene(from, to_scene_name: String):
	player = from.player
	player.get_parent().remove_child(player)
	
	var full_path = scene_path + to_scene_name + ".tscn"
	from.get_tree().call_deferred("change_scene_to_file", full_path)

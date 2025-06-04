class_name Portal
extends Area2D

@export var connected_scene : String
@export var enter_pos : Vector2

var scene_folder = "res://scene/"

func _on_body_entered(body: Node2D) -> void:
	if body is Player and get_tree().current_scene.scene_file_path != "res://Battle/battle.tscn":
		
		StatLoader.previous_position = enter_pos
		print(StatLoader.previous_position)
		
		#print(body.global_position)
		var full_path = scene_folder + connected_scene + ".tscn"
		var scene_tree = get_tree()
		scene_tree.call_deferred("change_scene_to_file", full_path)
		if connected_scene not in StatLoader.dead_array:
			StatLoader.dead_array.append(connected_scene)
			StatLoader.previous_scene = get_tree().current_scene.scene_file_path
			scene_tree.call_deferred("change_scene_to_file", connected_scene)
	

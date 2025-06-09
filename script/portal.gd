class_name Portal
extends Area2D
@export var new_inv: Inv
@export var connected_scene : String
@export var enter_pos : Vector2
@export var one_shot : bool
@export var stats : playerStat
var scene_folder = "res://scene/"

func _on_body_entered(body: Node2D) -> void:
	if connected_scene == "main_menu" and  body is Player:
		body.inv = new_inv
		StatLoader.player_group.clear()
		body.stats = stats 
	if body is Player and get_tree().current_scene.scene_file_path != "res://Battle/battle.tscn":
		
		StatLoader.previous_position = enter_pos
		print(StatLoader.previous_position)
		
		#print(body.global_position)
		var full_path = scene_folder + connected_scene + ".tscn"
		var scene_tree = get_tree()
		

		if full_path not in StatLoader.dead_array:
			if one_shot:
				StatLoader.dead_array.append(full_path)
				StatLoader.previous_scene = get_tree().current_scene.scene_file_path
				StatLoader.previous_position = body.global_position
			scene_tree.call_deferred("change_scene_to_file", full_path)
	


func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

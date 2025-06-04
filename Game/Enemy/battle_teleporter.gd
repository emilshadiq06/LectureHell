extends Area2D
class_name battle_teleport
#var scene : String = "res://Battle/battle.tscn"
var fight_path = preload("res://Battle/battle.tscn")
var fight 
func _on_body_entered(body: Node2D) -> void:
	if fight_path.resource_path== "res://Battle/battle.tscn" and body is Player:
		fight = fight_path.instantiate()
		var current_scene = get_tree().current_scene 
		print("smthsmth")
		print(body)
		print(get_parent().player)
		if body == get_parent().player and get_parent().name not in StatLoader.dead_array and get_parent().chase and current_scene.scene_file_path != "res://Battle/battle.tscn":
			if DialogueManagerScript.text_box:
				DialogueManagerScript.text_box.queue_free()
				DialogueManagerScript.is_dialog_active = false
				DialogueManagerScript.current_line_index = 0
				
		
			get_whole_group(get_parent().group_str)
			$"../../CanvasLayer".show()
			$"../../CanvasLayer/Control2".show()
			
			var player_Battle = fight.get_node("PlayerGroup").get_node("Character")
			player_Battle.get_node("skill").set_script(body.get_node("skill").get_script())
			get_whole_group_player()
			player_Battle.set_stats(body.stats)
			player_Battle.change_sprite(body.sprite)
			StatLoader.get_skill(body.get_node("skill"))
			StatLoader.previous_scene = get_parent().get_parent().scene_file_path 
			StatLoader.previous_position =body.global_position
			#Function.load_screen_to_scene("res://Battle/battle.tscn", {"test": "test"})
			
			get_tree().get_root().add_child(fight)
			
			get_tree().current_scene = fight
			
			await get_tree().create_timer(1).timeout
			current_scene.queue_free()

func get_whole_group(group):
	var enemy_Battle = fight.get_node("EnemyGroup")
	
	if get_parent().is_in_group(group):
		for i in range(get_tree().get_nodes_in_group(group).size()):
			StatLoader.dead_array.push_back((get_tree().get_nodes_in_group(group)[i]).name)
			enemy_Battle.add_character()
			#if get_tree().get_nodes_in_group(group)[i].find_child("stats"):
				
			fight.get_node("EnemyGroup").get_child(i +1).set_stats(get_tree().get_nodes_in_group(group)[i].stats)
			fight.get_node("EnemyGroup").get_child(i +1).change_sprite(get_tree().get_nodes_in_group(group)[i].sprite)
	else:
		StatLoader.dead_array.push_back(get_parent().name)
		enemy_Battle.add_character()
		fight.get_node("EnemyGroup").get_child(1).set_stats(get_parent().stats)
		fight.get_node("EnemyGroup").get_child(1).change_sprite(get_parent().sprite)
func get_whole_group_player():
	for i in range(StatLoader.player_group.size()):
		var player_inBattle = fight.get_node("PlayerGroup")
		player_inBattle.add_character()
		player_inBattle.get_child(i+1).set_stats(StatLoader.player_group[i].stats)
		player_inBattle.get_child(i+1).change_sprite(StatLoader.player_group[i].sprite) 
		player_inBattle.get_child(i+1).get_node("skill").set_script(StatLoader.player_group[i].get_node("skill").get_script())

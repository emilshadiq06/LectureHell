extends Area2D
class_name battle_teleport

@onready var fight = preload("res://Battle/battle.tscn").instantiate()
func _on_body_entered(body: Node2D) -> void:

	if body == get_parent().player and get_parent().name not in StatLoader.dead_array:
		DialogueManagerScript.is_dialog_active = false
		DialogueManagerScript.current_line_index = 0
		var current_scene = get_tree().current_scene
		
		get_whole_group(get_parent().group_str)
		
		var player_Battle = fight.get_node("PlayerGroup").get_node("Character")
		player_Battle.get_node("skill").set_script(body.get_node("skill").get_script())
		#print("herre")
		#print(body.get_stats())
		get_whole_group_player()
		#StatLoader.get_stats_player(body.get_stats())
		player_Battle.set_stats(body.stats)
		player_Battle.change_sprite(body.sprite)
		StatLoader.get_skill(body.get_node("skill"))
		StatLoader.previous_scene = get_parent().get_parent().scene_file_path 
		StatLoader.previous_position =body.global_position

		get_tree().get_root().add_child(fight)
		get_tree().current_scene = fight
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

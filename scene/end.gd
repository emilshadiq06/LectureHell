extends Portal


#@export var new_inv: Inv

@export var stats : playerStat


func _on_body_entered(body: Node2D) -> void:
	if body is Player and get_tree().current_scene.scene_file_path != "res://Battle/battle.tscn":
		body.stats.money = 20
		body.stats.hp = 20
		body.change_stat(20,20,250,0.1)
		var bare_handed : Array[Array] = [[2,1.0],[1,1.0],[2,1.0]]
		body.change_weapon(bare_handed)
		for i in body.stats.skill:
			body.stats.skill.clear()
		for i in StatLoader.player_group:
			if i.stats.skill.size()>1:
				i.stats.skill.remove_at(1)
		body.addskill("skill:String",stats.skill[0])
		for i in range(body.inv.items.size()):
			#print(i)

			body.inv.throw(i,body.inv.items[i])
			#print(i)
		StatLoader.quest_array.clear()
		StatLoader.dead_array.clear()
		StatLoader.player_group.clear()
		StatLoader.previous_position = enter_pos
		print(StatLoader.previous_position)
		
		#print(body.global_position)
		var full_path = scene_folder + connected_scene + ".tscn"
		var scene_tree = get_tree()
		

		if full_path not in StatLoader.dead_array:
			if one_shot:
				StatLoader.dead_array.append(full_path)
				#StatLoader.previous_scene = get_tree().current_scene.scene_file_path
				StatLoader.previous_position = body.global_position
			scene_tree.call_deferred("change_scene_to_file", full_path)
	


func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

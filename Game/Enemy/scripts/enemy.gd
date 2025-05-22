class_name Enemy extends CharacterBody2D
@onready var player = get_node("../Player")
@onready var state_machine  = $EnemyStateMachine
@onready var fight = preload("res://Battle/battle.tscn").instantiate()
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

const SPEED = 100.0
var chase_dir : Vector2
var chase : bool = false 

func _ready() -> void:
	state_machine.initialize(self)
	#direction.y = 1
	pass # Replace with function body.

func _process(delta: float) -> void:
	if chase == true:
		chase_dir = (player.position-position).normalized()
	pass
	
func _physics_process(delta: float) -> void:

	move_and_slide()
	


func choose_randomly(list_of_entries):
	return list_of_entries[randi() % list_of_entries.size()]
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player and self.name not in StatLoader.dead_array:
		DialogueManagerScript.is_dialog_active = false
		DialogueManagerScript.current_line_index = 0
		var current_scene = get_tree().current_scene
		
		get_whole_group("enemies")
		
		var player_Battle = fight.get_node("PlayerGroup").get_node("Character")
		player_Battle.get_node("skill").set_script(body.get_node("skill").get_script())
		#print("herre")
		#print(body.get_stats())
		get_whole_group_player()
		StatLoader.get_stats_player(body.get_stats())
		player_Battle.set_stats(body.get_stats())
		StatLoader.get_skill(body.get_node("skill"))
		StatLoader.previous_scene = get_parent().scene_file_path
		StatLoader.previous_position =body.global_position
		#StatLoader.dead_array.push_back(self)
		#print(StatLoader.dead_array)
		#print(StatLoader.previous_scene)
		#print(StatLoader.return_skill().get_skill_effects())
		
		
		#print("here xoxo")
		#print(player_Battle.get_node("skill").update_skill())
		get_tree().get_root().add_child(fight)
		get_tree().current_scene = fight
		current_scene.queue_free()

func get_whole_group(group):
	var enemy_Battle = fight.get_node("EnemyGroup")
	
	if self.is_in_group(group):
		for i in range(get_tree().get_nodes_in_group(group).size()):
			StatLoader.dead_array.push_back((get_tree().get_nodes_in_group(group)[i]).name)
			enemy_Battle.add_character()
			if get_tree().get_nodes_in_group(group)[i].find_child("stats"):
				
				var enemyGroup_Battle = fight.get_node("EnemyGroup").get_child(i +1).set_stats(get_tree().get_nodes_in_group(group)[i].get_node("stats").get_stats())
	else:
		StatLoader.dead_array.push_back(self.name)
		enemy_Battle.add_character()
			
func get_whole_group_player():
	for i in range(StatLoader.player_group.size()):
		var player_inBattle = fight.get_node("PlayerGroup")
		player_inBattle.add_character()
		player_inBattle.get_child(i+1).set_stats(StatLoader.player_group[i].get_node("stats").get_stats())
		player_inBattle.get_child(i+1).get_node("skill").set_script(StatLoader.player_group[i].get_node("skill").get_script())
		

func _on_chase_area_body_entered(body) -> void:
	if body == player:
		chase = true

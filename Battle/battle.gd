extends Node2D
#signal return_battle

var parameters: Dictionary
var win : bool = false
var lose : bool = false
var group_player_array= []
var group_enemy_array= []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StatLoader.was_just_inBattle = true
	var players = $PlayerGroup
	var enemies = $EnemyGroup
	group_player_array =  players.get_children()
	group_enemy_array = enemies.get_children()





func _on_enemy_group_start_turn() -> void:
	lose = count_hp(group_player_array)
	win = count_hp(group_enemy_array)
	print(win)
	var scene_tree = get_tree()
	if win == true:
		StatLoader.money += 50
		scene_tree.call_deferred("change_scene_to_file", StatLoader.previous_scene)
	

func count_hp(group) -> bool:
	var array_hp : float 
	for i in group:
		if i.hp<0:
			array_hp += 0
		else:
			array_hp += i.hp
	if array_hp <= 0:
		
		return true
	return false

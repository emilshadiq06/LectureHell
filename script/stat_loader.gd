extends Node
var skill_node
var dead_array : Array
signal update_group(member_stats:stat,position:int)
#var take_damage: int
#var max_hp : int
#var hp : int
#var max_pp : int
#var pp : int
var money : float
var player_group= []
#var weapon = 1
var previous_scene : String
var was_just_inBattle: bool =  false
var previous_position : Vector2

#func get_stats_player(target_body):
	# [stats.hp, stats.weapon, stats.pp, stats.pp ,stats.max_hp ,stats.money, stats.inventory]


#func return_stats():
#	print([hp,weapon,pp,max_pp,money,max_hp])
	#return [hp,weapon,pp,max_pp,money,max_hp]
	
func get_skill(target_node:Node):
	
	skill_node = target_node
	
func return_skill():
	return skill_node
	
func addplayer_to_group(added):
	
	player_group.append(added)
	update_group.emit(added.stats,player_group.find(added)+1)
		
	

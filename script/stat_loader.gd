extends Node
var skill_node
var dead_array : Array
var quest_array : Array
signal update_group(member_stats:stat,position:int)

var money : float
var player_group= []

var previous_scene : String
var was_just_inBattle: bool =  false
var previous_position : Vector2

	
func get_skill(target_node:Node):
	
	skill_node = target_node
	
func return_skill():
	return skill_node
	
func addplayer_to_group(added):
	
	player_group.append(added)
	update_group.emit(added.stats,player_group.find(added)+1)
		
	

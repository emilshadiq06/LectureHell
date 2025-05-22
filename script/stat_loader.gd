extends Node
var skill_node
var dead_array : Array
var take_damage: int
var max_hp : int
var hp : int
var pp : int
var money : int
var inventory = []
var player_group= []
var weapon = 1
var previous_scene : String
var was_just_inBattle: bool =  false
var previous_position : Vector2

func get_stats_player(target_body):
	hp = target_body[0]
	weapon = target_body[1]
	pp = target_body[2]
	
	money = target_body[3]
	inventory = target_body[4]
	max_hp = target_body[5]

func return_stats():
	print([hp,weapon,pp,inventory,money,max_hp])
	return [hp,weapon,pp,inventory,money,max_hp]
	
func get_skill(target_node:Node):
	
	skill_node = target_node
	
func return_skill():
	return skill_node
	
	
	

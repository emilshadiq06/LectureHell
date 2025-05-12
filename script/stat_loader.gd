extends Node

var skill_node
var take_damage: int = 0
var hp : int = 40
var pp = 20
var inventory = []
var weapon = 1

func get_stats_player(target_body):
	hp = target_body.hp
	pp = target_body.pp
	weapon = target_body.weapon

func return_stats():
	return [hp,weapon,pp,inventory]
	
func get_skill(target_node:Node):
	skill_node = target_node
	
func return_skill():
	print(skill_node.get_skill_effects())
	return skill_node
	
	

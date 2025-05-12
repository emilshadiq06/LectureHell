class_name skills extends Node
var turn = 0
var skill_name = "default"
var skill_desc = "default"
var hp_regen : int = 0
var pp_regen = 0
var dmg_multiplier_attack = 1
var dmg_multiplier_received= 1
var turns_duration = 1

func get_skill_effects():
	return [skill_name,skill_desc,hp_regen,pp_regen,dmg_multiplier_attack,dmg_multiplier_received,turns_duration]

#func get_weapon():
	#return weapon 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#what happens when player enters state
func Enter() ->void:
	pass
	
#what happens when player enters state
func Exit() ->void:
	pass
	
#what happens during process in state
func Process():
	return null

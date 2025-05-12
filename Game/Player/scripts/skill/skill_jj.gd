extends skills

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skill_name = "JJ aisyah \n
	maimunah X \n
	\nvelocity X \n
	Garamramaram Madududung"
	skill_desc = "taunt enemies to raise attack damage dealt but also raise incoming damage too"

	turns_duration = 2
	pass

#what happens when player enters state
func Enter() ->void:
	dmg_multiplier_attack = 1.2
	dmg_multiplier_received= 1.25
	pass
	
#what happens when player enters state
func Exit() ->void:
	pass
	
#what happens during process in state
func Process():
	return null

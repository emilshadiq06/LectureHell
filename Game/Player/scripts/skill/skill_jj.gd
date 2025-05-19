extends skills
var enemies
var players
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skill_name = "JJ aisyah \n
	maimunah X \n
	\nvelocity X \n
	Garamramaram Madududung"
	skill_desc = "taunt enemies to raise attack damage dealt but also raise incoming damage too"
	dmg_multiplier_attack = 20
	
	dmg_multiplier_received= 1.25
	turns_duration = 3
	cooldown += 1
	
	pass

#what happens when player enters state
func Enter() ->void:
	enemies = $"../../EnemyGroup"
	players = $"../../PlayerGroup"
	enemies.damage_multiplier *= dmg_multiplier_attack
	players.play_dance()
	enemies.emit_signal("next_player")
	enemies.action_queue.push_back("null")
	if enemies.action_queue.size() < players.players.size():
		enemies.show_choice()
	pass
	
#what happens when player enters state
func Exit() ->void:
	enemies.damage_multiplier /= dmg_multiplier_attack
	players.stop_anim()
	pass
	
#what happens during process in state
func Process():
	return null

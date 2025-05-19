extends skills
var enemies
var players
var sleeping_player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skill_name = "nap"
	skill_desc = "take a nap to regen health, but unable to make a move"
	hp_regen = 5
	turns_duration = 3
	cooldown += 2
	
	pass

#what happens when player enters state
func Enter() ->void:
	enemies  = $"../../EnemyGroup"
	players = $"../../PlayerGroup"
	sleeping_player = players.index
	#print(enemies.action_queue)
	#print("mmimimimi")
	players.players[sleeping_player].sprite.rotation_degrees += 90
	enemies.emit_signal("next_player")
	enemies.action_queue.push_back("null")
	if enemies.action_queue.size() < players.players.size():
		enemies.show_choice()
	pass
	
#what happens when player enters state
func Exit() ->void:
	players.players[sleeping_player].sprite.rotation_degrees -= 90
	pass
	
#what happens during process in state
func Process():
	players.players[sleeping_player].hp += hp_regen
	if players.index == sleeping_player:
		
		enemies.emit_signal("next_player")
		enemies.action_queue.push_back("null")
	if enemies.action_queue.size() < players.players.size():
		enemies.show_choice()
		print(enemies.action_queue)
		print("honkshooo mmimimimi")
	return null

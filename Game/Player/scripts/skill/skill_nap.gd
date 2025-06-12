extends skills
var enemies
var players
var sleeping_player
#var once : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skill_name = "nap"
	skill_desc = "take a nap to regen health, but unable to make a move"
	hp_regen = 5
	pp_regen = 5
	turns_duration = 3
	cooldown = 5
	
	pass

#what happens when player enters state
func Enter() ->void:
	enemies  = $"../../EnemyGroup"
	players = $"../../PlayerGroup"
	sleeping_player = players.index
	#print(enemies.action_queue)
	#print("mmimimimi")
	players.players[sleeping_player].sprite.rotation_degrees += 90
	
	players._on_brace_pressed()
	#enemies.emit_signal("next_player")
	#enemies.action_queue.push_back("null")
	#if enemies.action_queue.size() < players.players.size():
	#	enemies.show_choice()
	var sfx = load("res://sounds/sleeping.mp3")
	$"../../AudioStreamPlayer".stream = sfx
	$"../../AudioStreamPlayer".play()
	pass
	
#what happens when player enters state
func Exit() ->void:
	players._on_brace_pressed()
	players.players[sleeping_player].sprite.rotation_degrees -= 90
	pass
	
#what happens during process in state
func Process():
	var sfx = load("res://sounds/sleeping.mp3")
	$"../../AudioStreamPlayer".stream = sfx
	$"../../AudioStreamPlayer".play()
	$"../../AudioStreamPlayer".play()
	if players.index == sleeping_player and players.players[sleeping_player].hp >0: # and enemies.action_queue.size() < players.index + 1:
		players.players[sleeping_player].hp += hp_regen
		players.players[sleeping_player].pp += pp_regen
		players._on_brace_pressed()

	return null

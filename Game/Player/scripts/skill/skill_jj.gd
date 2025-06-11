extends skills
var enemies
var dancer : int
var players
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skill_name = "JJ aisyah \n
	maimunah X \n
	velocity X \n
	Garamramaram\n Madududung"
	skill_desc = "taunt enemies to raise attack damage dealt but also raise incoming damage too"
	dmg_multiplier_attack = 1.5
	
	dmg_multiplier_received= 1.5
	turns_duration = 3
	cooldown = 4
	
	pass

#what happens when player enters state
func Enter() ->void:
	
	enemies = $"../../EnemyGroup"
	players = $"../../PlayerGroup"
	players.in_damage_multiplier *= dmg_multiplier_received
	enemies.damage_multiplier *= dmg_multiplier_attack
	players.play_dance()
	dancer = players.index
	players._on_brace_pressed()
	
	var sfx = load("res://sounds/Maimunah.mp3")
	$"../../AudioStreamPlayer".stream = sfx
	$"../../AudioStreamPlayer".volume_db = -15
	$"../../AudioStreamPlayer".play()
	pass
	
#what happens when player enters state
func Exit() ->void:
	enemies.damage_multiplier /= dmg_multiplier_attack
	players.in_damage_multiplier /= dmg_multiplier_received
	print("i cant stop")
	$"../../AudioStreamPlayer".volume_db = 0
	players.stop_anim(dancer)
	players.players[dancer].sprite.set_frame(15)
	
	pass
	
#what happens during process in state
func Process():
	return null

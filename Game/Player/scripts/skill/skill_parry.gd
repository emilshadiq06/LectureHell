extends skills
var enemies

var players
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skill_name = "Parry"
	skill_desc = "deflect enemy attacks within a 0.25 window. 1s cooldown (RED ATTACKS CANT BE PARRIED)"

	turns_duration = 4
	cooldown = 5
	
	pass

#what happens when player enters state
func Enter() ->void:
	
	#enemies = $"../../EnemyGroup"
	players = $"../../PlayerGroup"
	players.parry = 0
	#enemies.damage_multiplier *= dmg_multiplier_attack
	#players.play_dance()
	#dancer = players.index
	players._on_brace_pressed()
	
	var sfx = load("res://Assets/sounds/shot_sound.wav")
	$"../../AudioStreamPlayer".stream = sfx
	$"../../AudioStreamPlayer".play()
	pass
	
#what happens when player enters state
func Exit() ->void:
	players.parry = 9999
	
	pass
	
#what happens during process in state
func Process():
	return null

extends skills
var enemies
var dancer : int
var players
var animated_sprite:AnimatedSprite2D = load("res://inventory/item/skill_items/gamble_anim.tscn").instantiate()
var player_stat : playerStat = load("res://Game/Player/player_stats.tres")
var effect_picked:effects
enum effects {damage_increase,damage_decrease,heal_hp_pp,reduce_hp_pp,kill_random_member}
var effect_pick_list : Array[effects] = [effects.damage_increase,effects.damage_increase,effects.damage_increase,effects.damage_decrease,effects.damage_decrease,effects.heal_hp_pp,effects.heal_hp_pp,effects.heal_hp_pp,effects.reduce_hp_pp,effects.reduce_hp_pp,effects.kill_random_member]
func _ready() -> void:
	skill_name = "gamble"
	skill_desc = "Bet 5 bucks for a random effect, positive or negative (Warning:All money used isn't visible)"

	turns_duration = 3
	cooldown = 4
	
	pass

#what happens when player enters state
func Enter() ->void:
	player_stat.money -= 5
	enemies = $"../../EnemyGroup"
	players = $"../../PlayerGroup"
	get_parent().get_parent().add_child(animated_sprite)
	animated_sprite.play("start_gamble")
	effect_picked = effect_pick_list.pick_random()
	var sfx = load("res://sounds/gambling.mp3")
	$"../../AudioStreamPlayer".stream = sfx
	$"../../AudioStreamPlayer".play()
	players._on_brace_pressed()
	await get_tree().create_timer(3).timeout
	match effect_picked:
		effects.damage_increase:
			animated_sprite.play("gamble+dmg")
			players.in_damage_multiplier *= 0.5
			enemies.damage_multiplier *= 1.5
			pass
		effects.damage_decrease:
			animated_sprite.play("gamble-dmg")
			players.in_damage_multiplier *= 1.5
			enemies.damage_multiplier *= 0.5
			pass
		effects.heal_hp_pp:
			animated_sprite.play("gamble+hp")
			for i in players.players:
				i.hp += 10
				i.pp += 10
			
			pass
		effects.reduce_hp_pp:
			animated_sprite.play("gamble-hp")
			for i in players.players:
				i.hp -= 5
				i.pp -= 5
			pass
		effects.kill_random_member:
			animated_sprite.play("gamble_kill")
			var list_of_guys:Array =  players.players + enemies.enemies
			var unfortunate_guy = list_of_guys.pick_random()
			unfortunate_guy.removehealth(unfortunate_guy.hp -1)
			pass
	sfx = load("res://sounds/moneysfx.mp3")
	$"../../AudioStreamPlayer".stream = sfx
	$"../../AudioStreamPlayer".play()
	await get_tree().create_timer(1).timeout
	
	get_parent().get_parent().remove_child(animated_sprite)



	pass
	
#what happens when player enters state
func Exit() ->void:
	match effect_picked:
		effects.damage_increase:
			#animated_sprite.play("gamble+dmg")
			players.in_damage_multiplier /= 0.75
			enemies.damage_multiplier /= 1.5
			pass
		effects.damage_decrease:
			#animated_sprite.play("gamble-dmg")
			players.in_damage_multiplier /= 1.5
			enemies.damage_multiplier /= 0.75
			pass
	
	#enemies.damage_multiplier /= dmg_multiplier_attack
	

	
	#players.stop_anim(dancer)
	#players.players[dancer].sprite.set_frame(15)
	
	pass
	
#what happens during process in state
func Process():
	
	return null

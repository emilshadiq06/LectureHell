extends skills
var enemies
var dancer : int
var players
var origin : Vector2
var bomber
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skill_name = "hit n run"
	skill_desc = "Attack a random enemy but sacrifice your health doing so"
	dmg_multiplier_attack = 1.5
	
	dmg_multiplier_received= 1.5
	turns_duration = 1
	cooldown = 4
	
	pass

#what happens when player enters state
func Enter() ->void:
	
	enemies = $"../../EnemyGroup"
	players = $"../../PlayerGroup"
	bomber = players.players[players.index]
	origin = bomber.global_position
	bomber.skateboard.show()
	AudioPlayer.play_audio("res://Assets/sounds/shot_sound.wav")
	players._on_brace_pressed()
	await get_tree().create_timer(1).timeout
	
	var tween = get_tree().create_tween().bind_node(bomber)#.set_trans(Tween.TRANS_ELASTIC)
	var hitted = enemies.enemies.pick_random()
		
	
		
	
		
	tween.tween_property(bomber, "global_position",hitted.global_position-bomber.global_position,0.35)
	
	bomber.hp -= 15
	hitted.removehealth(25*enemies.damage_multiplier)
	

	var sfx = load("res://sounds/zoom.wav")
	$"../../AudioStreamPlayer".stream = sfx
	$"../../AudioStreamPlayer".play()
	pass
	
#what happens when player enters state
func Exit() ->void:
	#enemies.damage_multiplier /= dmg_multiplier_attack
	
	bomber.global_position = origin
	await get_tree().create_timer(0.2).timeout
	bomber.skateboard.hide()
	
	#players.stop_anim(dancer)
	#players.players[dancer].sprite.set_frame(15)
	
	pass
	
#what happens during process in state
func Process():
	
	return null

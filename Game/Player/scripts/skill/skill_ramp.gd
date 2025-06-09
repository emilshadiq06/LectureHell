extends skills
var enemies
var players
var label
var demultiplier:float = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skill_name = "revv up"
	skill_desc = "increase damage but also arrow speed"
	#hp_regen = 5
	turns_duration = 3
	cooldown += 3
	dmg_multiplier_attack = 2
	pass

#what happens when player enters state
func Enter() ->void:
	enemies  = $"../../EnemyGroup"
	players = $"../../PlayerGroup"
	
	players._on_brace_pressed()

	var sfx = load("res://sounds/hard_kick.mp3")
	$"../../AudioStreamPlayer".stream = sfx
	$"../../AudioStreamPlayer".play()
	pass
	
#what happens when player enters state
func Exit() ->void:
	if label != null:
		label.queue_free()
	#enemies.damage_multiplier /= dmg_multiplier_attack
	for i in players.get_children():
		for j in range(i.weapons.size()):
			i.weapons[j][1] /=demultiplier
		
	pass
	
#what happens during process in state
func Process():
	if label != null:
		label.queue_free()
	label = Label.new()
	
	label.text = "Attack Speed:" + str(demultiplier)
	get_parent().get_parent().add_child(label)
	var sfx = load("res://sounds/hard_kick.mp3")
	$"../../AudioStreamPlayer".stream = sfx
	$"../../AudioStreamPlayer".play()
	for i in players.get_children():
		for j in range(i.weapons.size()):
			i.weapons[j][1] *=1.08
	demultiplier *=1.08
		
	return null

extends Node
@onready var players  =$"../PlayerGroup"
@onready var enemies = $"../EnemyGroup"
var skill : Array = [skills]
var origin : Array = []
var started = false
#func _ready() -> void:
#	process_mode = Node.PROCESS_MODE_DISABLED
	#pass # Replace with function body.

func initialize()->void:
	skill = []  
	origin = []
	
	for c in get_children():
		if c is skills:
			skill.append(c)
			origin.append(c.get_skill_effects())
			
	
	if skill.size()>0:
		DoEffect()
	started = true
		#process_mode = Node.PROCESS_MODE_INHERIT

func DoEffect():
	var skill_increment = 0
	for i in skill:
		
		if i.turn == 0:
			i.Enter()
			
		if i.turn < i.turns_duration:
			#enemies.damage_multiplier = i.dmg_multiplier_attack
			i.Process()
		if i.turn == i.turns_duration:

			i.Exit()
		if i.turn > i.cooldown:
			print(skill_increment)
			i.turn = 0
			skill.erase(i)
			origin.remove_at(skill_increment)
			remove_child(i)
		i.turn += 1
		skill_increment += 1
	


func _on_enemy_group_start_turn() -> void:
	if skill.size()>0 and started:
		DoEffect()

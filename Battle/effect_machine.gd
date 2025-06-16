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
func add_turns():
	for i in skill:
		if i != null:
			i.turn += 1
			
func DoEffect():
	var skill_increment = 0
	skill.erase(null)
	origin.erase(null)
	for i in skill:
		 
		if i.turn == 0:
			i.Enter()
			i.turn += 1
			
		elif i.turn < i.turns_duration and i.turn > 0:
			#enemies.damage_multiplier = i.dmg_multiplier_attack
			i.Process()
		elif i.turn == i.turns_duration:

			i.Exit()
		
		elif i.turn > i.cooldown:
			#print(skill)
			i.turn = 0
			skill[skill_increment] = null
			origin[skill_increment] = null
			#skill_increment -= 1
			remove_child(i)

		skill_increment += 1

	
	


func _on_enemy_group_start_turn() -> void:
	await get_tree().create_timer(0.05).timeout
	if skill.size()>0 and started and players.index == 0:
		DoEffect()
		add_turns()
	#pass


func _on_enemy_group_next_player() -> void:
	if skill.size()>0 and started and  players.index != 0:
		for i in skill:
			if i != null and i.turn < i.turns_duration and i.turn > 0:# and enemies.action_queue.size()<players.players.size():
				i.Process()
		print(enemies.action_queue)

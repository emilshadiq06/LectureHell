extends StaticBody2D

@export var stats : stat
@onready var dialogue_player = $Chat
@onready var sprite = $Sprite2D
@export var last_lines: Array[dialogue_lines]
@export var next_dialogue: Array[dialogue_lines]
#@export var alternate_outcome:bool = false
var player 
var chase: bool =  false
var finish: bool =  false
@export var dialoges: Dialogue = Dialogue.First
var group_str : String
var change_to_last
#var current_dialogue : int = 0
# Called when the node enters the scene tree for the first time.

enum Dialogue{First,Sec,Third}
func _ready() -> void:
	
	print(StatLoader.quest_array)
	next_dialogue[0] = dialogue_player.dialogue  
	
	DialogueManagerScript.finish_lines.connect(next_line)

	
	while next_dialogue[dialoges].quest_name in StatLoader.quest_array: 
		if next_dialogue[next_dialogue.size() - dialoges -1].quest_name in StatLoader.quest_array and StatLoader.quest_array[next_dialogue[next_dialogue.size() - dialoges -1].quest_name] == true and last_lines.size()>0 and last_lines[Dialogue.size() - dialoges -1-1] != null:
			change_to_last= last_lines[Dialogue.size() - dialoges -1-1]
			
			print(" lnl"+str(dialoges))
			break
		if dialoges + 1 < next_dialogue.size():
			print(" lll"+str(dialoges))
			dialoges += 1
			dialogue_player.dialogue = next_dialogue[dialoges]

			
		else:
			#next_line()
			break
	if self.name in StatLoader.dead_array: 
		if next_dialogue[dialoges].quest_name not in StatLoader.quest_array and next_dialogue[dialoges].fight:
			StatLoader.quest_array[next_dialogue[dialoges].quest_name]=false
			if dialoges + 1 < next_dialogue.size():
				dialoges += 1
				dialogue_player.dialogue = next_dialogue[dialoges]
		$CollisionShape2D.disabled = true
		
		
		print(" lnl"+str(dialoges))
	if change_to_last:
		dialogue_player.dialogue =  change_to_last
		
		next_line()
		hider()
	#else:
		#next_line()
		
		
		

	dialogue_player.dialog_branch.clear()
	dialogue_player.lines_array.clear()
	dialogue_player.dialogue.index = 0
		#dialogue_player.next_line()
	dialogue_player._ready()
	print("smtg"+str(dialogue_player.dialogue.index))
	pass # Replace with function body.

func next_line():
	
	
	player = dialogue_player.player
	hider()
	
			
	
			
	
			
	if  dialogue_player.dialogue.index == dialogue_player.lines_array.size()-1 and change_to_last == null  and dialogue_player.dialogue.fight and  player != null:
		chase = true
		if $battle_teleport != null:
			$battle_teleport.monitorable = true
			$battle_teleport.monitoring = true
			#StatLoader.quest_array.append( dialogue_player.dialogue.quest_name)
	elif change_to_last == null and player != null:# and  dialogue_player.dialogue.move_on_event_index<4:
		
		if dialogue_player.dialogue.move_on_last_index<3 and dialogue_player.dialogue.index == dialogue_player.lines_array.size()-1:
			if dialogue_player.dialogue.quest_name not in StatLoader.quest_array:
				StatLoader.quest_array[next_dialogue[dialoges].quest_name]=false
			dialoges =   dialogue_player.dialogue.move_on_last_index
			print(" lll"+str(dialoges))
			
	
		elif dialogue_player.dialogue.move_on_event_index<3  and dialogue_player.dialogue.index == dialogue_player.dialogue.event_index:
			if dialogue_player.dialogue.quest_name not in StatLoader.quest_array:
				StatLoader.quest_array[next_dialogue[dialoges].quest_name]=true
			dialoges =   dialogue_player.dialogue.move_on_event_index
			print(" lll"+str(dialoges))
			
	
	
			
	if dialogue_player.dialogue.ending != 999 and dialogue_player.dialogue.index == dialogue_player.dialogue.event_index and  player != null:
			
			StatLoader.quest_array[next_dialogue[dialoges].quest_name]=true
			change_to_last = last_lines[dialogue_player.dialogue.ending]
	if (( dialogue_player.dialogue.index == dialogue_player.lines_array.size()-1 and dialogue_player.dialogue.move_on_last_index<3 )  or ( dialogue_player.dialogue.index == dialogue_player.dialogue.event_index and dialogue_player.dialogue.move_on_event_index<3)) and change_to_last == null and  player != null:
		
		
		match dialoges:
	#
			Dialogue.Third:
				if player != null and next_dialogue[Dialogue.Sec].quest_name not in StatLoader.quest_array:
				#	StatLoader.quest_array.append(next_dialogue[Dialogue.Sec].quest_name)
					StatLoader.quest_array[next_dialogue[Dialogue.Sec].quest_name]=true
		dialogue_player.dialogue = next_dialogue[dialoges]
		dialogue_player.dialog_branch.clear()
		
		dialogue_player.dialogue.index = 0
		dialogue_player._ready()
		dialogue_player.dialogue.get_stuff(dialogue_player)
		
		if dialogue_player.player != null:
			dialogue_player.is_chatting = false
			await get_tree().create_timer(1).timeout
			dialogue_player._on_body_entered(dialogue_player.player)
		print(StatLoader.quest_array)
		print(dialoges)
		print(next_dialogue[0].quest_name)
		print(dialogue_player.dialogue.quest_name)
			
			
	if (change_to_last and !finish):
		if  change_to_last == last_lines[0]:
			if $man and $explode:
				$man.play("burning")
				$man.scale *= 3
				$man.modulate =Color("orange")
				$explode.play("explode")
				AudioPlayer.play_audio("res://sounds/explosion.mp3")
		else:
			if $man and $explode:
				print("s")
				$explode.play("explode")
				AudioPlayer.play_audio("res://sounds/explosion.mp3")

			
		dialogue_player.dialogue =  change_to_last
		dialogue_player.dialog_branch.clear()
		dialogue_player.lines_array.clear()
		dialogue_player.dialogue.index = 0
		dialogue_player._ready()
		dialogue_player.dialogue.get_stuff(dialogue_player)
		
		finish = true
		
		if dialogue_player.player!= null:
			dialogue_player.is_chatting = false
			await get_tree().create_timer(1).timeout
			
			dialogue_player._on_body_entered(dialogue_player.player)
			#if change_to_last and finish and change_to_last == last_lines[1]:



		
func hider():
	if finish and change_to_last == last_lines[1]:
		if $man:
			$man.hide()
		elif $Sprite2D:
			$Sprite2D.hide()
		dialogue_player.monitoring = false
		dialogue_player.monitorable= false

		

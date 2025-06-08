extends StaticBody2D

@export var stats : stat
@onready var dialogue_player = $Chat
@onready var sprite = $Sprite2D
@export var last_lines: Array[dialogue_lines]
@export var next_dialogue: Array[dialogue_lines]
@export var alternate_outcome:bool = false
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
	if self.name in StatLoader.dead_array:
		StatLoader.quest_array.append( dialogue_player.dialogue.quest_name)
		$CollisionShape2D.disabled = true
	DialogueManagerScript.finish_lines.connect(next_line)

	
	while dialogue_player.dialogue.quest_name in StatLoader.quest_array: 
		if next_dialogue[next_dialogue.size() - dialoges -1].quest_name in StatLoader.quest_array and last_lines.size()>0:
			change_to_last= last_lines[Dialogue.size() - dialoges -1-1]

			break
		if dialoges + 1 < next_dialogue.size():
			dialoges += 1

			dialogue_player.dialogue = next_dialogue[dialoges]
		else:
			break
	if change_to_last:
		dialogue_player.dialogue =  change_to_last
		
		next_line()
		hider()
		
		

	dialogue_player.dialog_branch.clear()
	dialogue_player.lines_array.clear()
	dialogue_player.dialogue.index = 0
		#dialogue_player.next_line()
	dialogue_player._ready()
	pass # Replace with function body.

func next_line():
	
	#if change_to_last and finish and change_to_last == last_lines[1]:
		#dialogue_player.monitoring = false
		#dialogue_player.monitorable= false
	
	player = dialogue_player.player
	hider()
	match dialoges:
		Dialogue.First:
			if  dialogue_player.dialogue.index == dialogue_player.lines_array.size()-1 and change_to_last == null  and !dialogue_player.move_if_true:
				chase = true
				if $battle_teleport != null:
					$battle_teleport.monitorable = true
					$battle_teleport.monitoring = true
			#StatLoader.quest_array.append( dialogue_player.dialogue.quest_name)
			elif alternate_outcome and dialogue_player.dialogue.index == dialogue_player.dialogue.event_index and change_to_last == null and !dialogue_player.move_if_true:
				dialoges = Dialogue.Third
				
				StatLoader.quest_array.append(next_dialogue[Dialogue.Sec].quest_name)
			
	#if (!alternate_outcome and dialogue_player.dialogue.index == dialogue_player.dialogue.event_index):
		#match dialoges:
		Dialogue.Sec: 
			if !alternate_outcome and dialogue_player.dialogue.index == dialogue_player.dialogue.event_index and change_to_last == null :

				
				change_to_last = last_lines[0]
				
		Dialogue.Third:
			if dialogue_player.dialogue.index == dialogue_player.dialogue.event_index and change_to_last == null :
				if last_lines.size()>1:
					change_to_last  = last_lines[1]

	
		

	if ( dialogue_player.dialogue.index == dialogue_player.lines_array.size()-1 and !dialogue_player.move_if_true )  and change_to_last == null or (alternate_outcome and dialogue_player.dialogue.index == dialogue_player.dialogue.event_index) and change_to_last == null:
		if  dialoges + 1 < next_dialogue.size():
			
			dialoges += 1
		#StatLoader.quest_array.append( dialogue_player.dialogue.quest_name)
		
			
		match dialoges:
			Dialogue.First:
				dialogue_player.dialogue = next_dialogue[Dialogue.First]
			Dialogue.Sec:
				
				dialogue_player.dialogue = next_dialogue[Dialogue.Sec]
			Dialogue.Third:
				
				dialogue_player.dialogue = next_dialogue[Dialogue.Third]
		
		dialogue_player.dialog_branch.clear()
		dialogue_player.lines_array.clear()
		dialogue_player.dialogue.index = 0
		dialogue_player._ready()
		dialogue_player.dialogue.get_stuff(dialogue_player)
		
		if dialogue_player.player != null:
			dialogue_player.is_chatting = false
			await get_tree().create_timer(1).timeout
			
			dialogue_player._on_body_entered(dialogue_player.player)
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

		

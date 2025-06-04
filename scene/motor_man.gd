extends StaticBody2D

@export var stats : stat
@onready var dialogue_player = $Chat
@onready var sprite = $Sprite2D
@export var next_dialogue: Array[dialogue_lines]

var player 
#var chase: bool =  false
@export var dialoges: Dialogue = Dialogue.First
var group_str : String
#var current_dialogue : int = 0
# Called when the node enters the scene tree for the first time.

enum Dialogue{First,Sec,Third}
func _ready() -> void:
	
	next_dialogue[0] = dialogue_player.dialogue  

	DialogueManagerScript.finish_lines.connect(next_line)
	while dialogue_player.dialogue.quest_name in StatLoader.quest_array: 
		if dialoges + 1 < Dialogue.size():
			dialoges += 1
	
		dialogue_player.dialogue = next_dialogue[dialoges]
	dialogue_player.dialog_branch.clear()
	dialogue_player.lines_array.clear()
	dialogue_player.dialogue.index = 0
		#dialogue_player.next_line()
	dialogue_player._ready()
	pass # Replace with function body.

func next_line():
	
	player = dialogue_player.player

	if dialogue_player.dialogue == next_dialogue[0] and dialogue_player.dialogue.index == dialogue_player.lines_array.size()-1 and dialogue_player.dialogue.quest_name not in StatLoader.quest_array:
		if dialoges + 1 < Dialogue.size():
			
			dialoges += 1
		StatLoader.quest_array.append( dialogue_player.dialogue.quest_name)
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
		

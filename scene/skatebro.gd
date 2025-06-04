extends StaticBody2D

@export var stats : stat
@onready var dialogue_player = $Chat
@onready var sprite = $Sprite2D
@export var next_dialogue: Array[dialogue_lines]
@export var alternate_dialogue: Array[dialogue_lines]
var player 
var chase: bool =  false
var group_str : String
var current_dialogue : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_dialogue[0] = dialogue_player.dialogue  
	print(next_dialogue.size()-1)
	print(next_dialogue[0].quest_name)
	print(next_dialogue[1].quest_name)
	DialogueManagerScript.finish_lines.connect(next_line)
	if self.name in StatLoader.dead_array: 
		
		next_dialogue = alternate_dialogue
		dialogue_player.dialogue = next_dialogue[0]
		dialogue_player.dialog_branch.clear()
		dialogue_player.lines_array.clear()
		dialogue_player.dialogue.index = 0
		#dialogue_player.next_line()
		dialogue_player._ready()
	pass # Replace with function body.

func next_line():
	player = dialogue_player.player
	print("here")
	print(next_dialogue.size()-1)
	if dialogue_player.dialogue == next_dialogue[0] and dialogue_player.dialogue.index == dialogue_player.lines_array.size()-1 and self.name not in StatLoader.dead_array:
		chase = true
		$battle_teleport.monitorable = true
		$battle_teleport.monitoring = true
		
	elif dialogue_player.dialogue.quest_name in StatLoader.quest_array and current_dialogue+1 <= next_dialogue.size()-1:
		
		if DialogueManagerScript.text_box:
			DialogueManagerScript.text_box.queue_free()
			DialogueManagerScript.is_dialog_active = false
			DialogueManagerScript.current_line_index = 0
			
		current_dialogue += 1
		if next_dialogue.size() > current_dialogue:
			dialogue_player.dialogue = next_dialogue[current_dialogue]
			dialogue_player.dialog_branch.clear()
			dialogue_player.lines_array.clear()
			dialogue_player.dialogue.index = 0
		
		dialogue_player._ready()
		dialogue_player.dialogue.get_stuff(dialogue_player)
		print("well well well items")
		print(dialogue_player.item_count)
		#dialogue_player.dialog_branch[dialogue_player.dialogue.position[dialogue_player.dialogue.index]][0][1] = dialogue_player.dialogue.index
		print("well well well")
		
		#dialogue_player.next_line()

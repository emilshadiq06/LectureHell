extends Area2D
class_name DialogueBranch
@export var quest_name : String
#var quest_completed:bool = false
@export var dialogue: dialogue_lines  
@export var item: InvItem 
@export var item_count: int
@export var lose_on_found :bool
@export var prized_item: InvItem
@export var add_to_group: int =999
@export var money: float
var player

var dialog_branch : Array
var is_chatting : bool = false



var lines_array:Array 
# Node paths

func _ready():
	
	lines_array = dialogue.get_lines() 
	dialog_branch = dialogue.get_lines_option()
	#print("i scrape my left nut in each odd numbered seat corner in the CNMX3 lecture hall and my right one on the even ones")
	DialogueManagerScript.finish_lines.connect(next_line)


func next_line():
	if  dialogue.index < dialog_branch.size():
		print(dialogue.index)
		print(dialog_branch.size())
		$DialogueOptions.show()
		$DialogueOptions/Option1.text = dialog_branch[dialogue.position[dialogue.index]][0][0]
		$DialogueOptions/Option1.item_index = 0
		$DialogueOptions.get_child(0).item_pos.connect(item_pressed)
		for i in range(dialog_branch[dialogue.position[dialogue.index]].size()-1):
			var new_button = $DialogueOptions/Option1.duplicate()
			new_button.text = dialog_branch[dialogue.position[dialogue.index]][i+1][0]
			new_button.item_index  = i+1
			$DialogueOptions.add_child(new_button)
			$DialogueOptions.get_child(i+1).item_pos.connect(item_pressed)
	pass
	
func item_pressed(item_index:int):
	#print(item_index)
	#if dialog_branch[index][item_index][1] and index<1:
		
		for i in range(dialog_branch[dialogue.position[dialogue.index]].size()-1):
			$DialogueOptions.remove_child($DialogueOptions.get_child($DialogueOptions.get_children().size()-1))
			
		dialogue.index = dialog_branch[dialogue.position[dialogue.index]][item_index][1]
		if dialogue.index == dialogue.event_index and player.find_item(item).size()>=item_count:
			if prized_item != null:
				player.collect_item(prized_item.duplicate())
			if lose_on_found:
				for i in player.find_item(item):
					player.inv.throw(i,player.inv.items[i])
			if add_to_group < 2 and StatLoader.player_group.size()<3:
				var team = load("res://Game/Player/player_team.tscn").instantiate()
				StatLoader.addplayer_to_group(team.get_child(add_to_group).duplicate())
				team = null
				
			StatLoader.quest_array.append(quest_name)
			player.buy(-money) 
		elif dialogue.index == dialogue.event_index and player.find_item(item) == null and quest_name not in StatLoader.quest_array:
			dialogue.index = lines_array.size()-1

		DialogueManagerScript.start_dialog(global_position, lines_array[dialogue.index])
		$DialogueOptions.hide()
	
		
		
		
func _on_body_entered(body: Node2D) -> void:
	if body is Player :
		if quest_name in StatLoader.quest_array:
			dialogue.index = dialogue.event_index
		DialogueManagerScript.start_dialog(global_position, lines_array[dialogue.index])
		is_chatting = true
		player = body

func _on_body_exited(body: Node2D) -> void:
	if body is Player and is_chatting:
		$DialogueOptions.hide()
		if is_chatting and DialogueManagerScript.is_dialog_active == true:
			DialogueManagerScript.text_box.queue_free()
			DialogueManagerScript.is_dialog_active = false
			DialogueManagerScript.current_line_index = 0
		is_chatting = false
		player = null

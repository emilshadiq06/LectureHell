extends Area2D
class_name DialogueBranch
#@export var quest_name : String
#var quest_completed:bool = false

@export var dialogue: dialogue_lines  
@export var move_if_true: bool = false
var item: InvItem
var item_count: int  
var lose_on_found :bool 
var prized_item: InvItem 
var add_to_group: int
var money: float 

var player

var dialog_branch : Array
var is_chatting : bool = false



var lines_array:Array 
# Node paths

func _ready():
	
	lines_array = dialogue.get_lines() 
	dialog_branch = dialogue.get_lines_option()
	
	DialogueManagerScript.finish_lines.connect(next_line)
	await DialogueManagerScript.finish_lines.connect(next_line)
	dialogue.get_stuff(self)



func next_line():
	
	# dialogue.index < dialog_branch.size() and
	if dialogue.index < dialog_branch.size() and player != null and dialogue.position[dialogue.index] < dialog_branch.size():
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
			if $DialogueOptions.get_child(i+1) == null:
				$DialogueOptions.add_child(new_button)
				$DialogueOptions.get_child(i+1).item_pos.connect(item_pressed)
	pass
	
func item_pressed(item_index:int):
	#print(item_index)
	#if dialog_branch[index][item_index][1] and index<1:
		print("item count")
		print(item_count)
		for i in range(dialog_branch[dialogue.position[dialogue.index]].size()-1):
			$DialogueOptions.remove_child($DialogueOptions.get_child($DialogueOptions.get_children().size()-1))
			
		dialogue.index = dialog_branch[dialogue.position[dialogue.index]][item_index][1]
		if item != null and dialogue.index == dialogue.event_index and player.find_item(item).size()>=item_count:
			print("item count")
			print(item_count)
			print(player.find_item(item).size())
			print("item count")
			if prized_item != null:
				print("empties")
				print(player.find_item(null).size())
				if player.find_item(null).size() == 0:
					player.player_invUI.selected_items = 0 
					player.player_invUI._on_throw_pressed()
					#player.inv.throw(0,player.inv.items[0])
				player.collect_item(prized_item.duplicate())
			if lose_on_found:
				#player.find_item(item)
				for i in range(item_count):
					
					player.inv.throw(player.find_item(item)[0],player.inv.items[player.find_item(item)[0]])
			if add_to_group < 2 and StatLoader.player_group.size()<3:
				var team = load("res://Game/Player/player_team.tscn").instantiate()
				StatLoader.addplayer_to_group(team.get_child(add_to_group).duplicate())
				team = null
				
			StatLoader.quest_array.append(dialogue.quest_name)
			player.buy(-money) 
			#print(StatLoader.quest_array)
		elif item != null and dialogue.index == dialogue.event_index and player.find_item(item).size()<item_count and dialogue.quest_name not in StatLoader.quest_array:
			dialogue.index = lines_array.size()-1
			print("item count")
			print(item_count)
			print(player.find_item(item).size())
			print("item count")
		DialogueManagerScript.start_dialog(get_parent().global_position, lines_array[dialogue.index])
		$DialogueOptions.hide()
	
	
		
		
func _on_body_entered(body: Node2D) -> void:
	if body is Player  and !is_chatting:
		if dialogue.quest_name in StatLoader.quest_array:
			dialogue.index = dialogue.event_index
		DialogueManagerScript.start_dialog(get_parent().global_position, lines_array[dialogue.index])
		is_chatting = true
		player = body

func _on_body_exited(body: Node2D) -> void:
	if body == player:
		$DialogueOptions.hide()
		if is_chatting and DialogueManagerScript.is_dialog_active == true:
			DialogueManagerScript.text_box.queue_free()
			DialogueManagerScript.is_dialog_active = false
			DialogueManagerScript.current_line_index = 0
		dialogue.index = 0
		
		is_chatting = false
		player = null

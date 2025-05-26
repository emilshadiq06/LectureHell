extends CharacterBody2D
var index: int = 0
# Define the NPC's properties
#var speed = 100
#var direction = Vector2.ZERO
#var target_position = Vector2.ZERO
@export var item: InvItem 
@export var prized_item: InvItem 
var player
var dialog_button : Array= [["Yeah",true],["Nah",false],["That's disgusting..",false]]
var dialog_button_after_yeah : Array= [["ok",true],["Nah, I love him",false]]
var dialog_branch = [dialog_button,dialog_button_after_yeah]
var is_chatting : bool = false

const lines: Array[String] = [
	"Hey you there",
	"Have you seen my pet fly?"
]

const lines2: Array[String] = [
	"Really?",
	"can I have it pls ); );"
]
const lines3: Array[String] = [
	"Thank you"
]
var lines_array = [lines,lines2,lines3]
# Node paths
@onready var sprite = $Sprite2D
@onready var collision = $ABU

func _ready():
	DialogueManagerScript.finish_lines.connect(next_line)


func next_line():
	if index <= dialog_branch.size()-1:
		$DialogueOptions.show()
		$DialogueOptions/Option1.text = dialog_branch[index][0][0]
		$DialogueOptions/Option1.item_index = 0
		$DialogueOptions.get_child(0).item_pos.connect(item_pressed)
		for i in range(dialog_branch[index].size()-1):
			var new_button = $DialogueOptions/Option1.duplicate()
			new_button.text = dialog_branch[index][i+1][0]
			new_button.item_index  = i+1
			$DialogueOptions.add_child(new_button)
			$DialogueOptions.get_child(i+1).item_pos.connect(item_pressed)
	pass
	
func item_pressed(item_index:int):
	#print(item_index)
	if dialog_branch[index][item_index][1] and index<1:

		for i in range(dialog_branch[index].size()-1):
			$DialogueOptions.remove_child($DialogueOptions.get_child($DialogueOptions.get_children().size()-1))
		index += 1
		DialogueManagerScript.start_dialog(global_position, lines_array[index])
		$DialogueOptions.hide()
	elif dialog_branch[index][item_index][1] and index==1 and player.find_item(item.name):
		#print("momomomo")
		#if player.find_item(item):
		print(player.find_item(item.name))
		player.inv.throw(player.find_item(item.name),player.inv.items[player.find_item(item.name)])
		player.collect_item(prized_item.duplicate())
		DialogueManagerScript.start_dialog(global_position, ["Have this as a token of my gratitude","'You received a charger flail'"])
			
		index += 1
		DialogueManagerScript.start_dialog(global_position, lines_array[index])
		$DialogueOptions.hide()
	else:
		for i in range(dialog_branch[index].size()-1):
			$DialogueOptions.remove_child($DialogueOptions.get_child($DialogueOptions.get_children().size()-1))
		DialogueManagerScript.start_dialog(global_position, ["You are a LIARRRR","get out of my sight"])
		$DialogueOptions.hide()
		
		
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player :
		
		DialogueManagerScript.start_dialog(global_position, lines_array[index])
		is_chatting = true
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player and is_chatting:
		$DialogueOptions.hide()
		if is_chatting and DialogueManagerScript.is_dialog_active == true:
			DialogueManagerScript.text_box.queue_free()
			DialogueManagerScript.is_dialog_active = false
			DialogueManagerScript.current_line_index = 0
		is_chatting = false
		player = null
		
		

extends Resource
class_name dialogue_lines
var index : int
@export var quest_name : String

@export var item: InvItem 
@export var item_count: int
@export var lose_on_found :bool
@export var prized_item: InvItem
@export var add_to_group: int =999
@export var money: float

@export var event_index: int
@export var lines1: Array[String]
@export var lines2: Array[String]
@export var lines3: Array[String]
@export var lines4: Array[String]
@export var lines5: Array[String]
@export var position: Array[int] = []
@export var line1Options : Array [Array]
@export var line2Options : Array [Array]
@export var line3Options : Array [Array]
@export var line4Options : Array [Array]

func get_stuff(target):
	target.item = item
	target.item_count = item_count
	target.lose_on_found  = lose_on_found
	target.prized_item = prized_item
	target.add_to_group = add_to_group
	target.money = money
func get_lines():
	var lines_array : Array = [lines1,lines2,lines3,lines4,lines5]
	var lines_array_new : Array
	for i in range(lines_array.size()):
		if lines_array[i].size() > 0:
			lines_array_new.append(lines_array[i]) 
		else:
			break
	return lines_array_new

func get_lines_option():
	var lines_array_option  : Array = [line1Options,line2Options,line3Options,line4Options]
	var lines_array_option_new  : Array [Array]
	for i in range(lines_array_option.size()):
		var size:int = lines_array_option[i].size()
		
		if size!=0:
			lines_array_option_new.append(lines_array_option[i])
		else:
			break
	return lines_array_option_new
			

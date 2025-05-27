extends Resource
class_name dialogue_lines
var index : int

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
			

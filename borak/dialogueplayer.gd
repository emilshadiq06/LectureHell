extends Control

signal dialogue_finished

@export_file("*.json") var d_file

var dialogue = []
var current_dialogue_id = 0
var d_active = false

func _ready():
	$Panel.visible = false
	
func start():
	prints("yes")
	if d_active:
		return
		d_active = true
		$Panel.visible = true
		dialogue = load_dialogue()
		current_dialogue_id = -1
		next_script()
	
func load_dialogue():
	var file = FileAccess.open("res://borak/worker_dialogue1.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content

func input_event(event):
	if !d_active:
		return
	if event.is_action_press("ui_accept"):
		next_script()

func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >=  len(dialogue):
		d_active = false
		$Panel.visible = false
		emit_signal("dialogue_finished")
		return
		
	$Panel/Name.text = dialogue[current_dialogue_id]['Name']
	$Panel/Text.text = dialogue[current_dialogue_id]['Text']
		

extends CanvasLayer


var index_selection = 0
var char_potrait

func _ready() -> void:
	char_potrait = $Sprite2D
	update_potrait(index_selection)
	
func update_potrait(index):
	char_potrait.texture = GlobalSettings.characters[index]
	

func _on_right_pressed() -> void:
	if(index_selection < GlobalSettings.characters.size()-1):
		index_selection +=1
	elif(index_selection == GlobalSettings.characters.size()-1):
		index_selection = 0
	update_potrait(index_selection)



func _on_left_pressed() -> void:
	if(index_selection > 0):
		index_selection -=1
	elif(index_selection == 0):
		index_selection = GlobalSettings.characters.size()-1
	update_potrait(index_selection)


func _on_select_pressed() -> void:
	GlobalSettings.selected_character = index_selection
	$characterui.update_potrait(index_selection)
	print("mantap sekali pilihan anda")

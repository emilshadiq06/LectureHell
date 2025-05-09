extends CanvasLayer

const characters = [
	preload("res://character/16x16 top down characters pixel art/character 1/16x16 top down character 1-1.png"),
	preload("res://character/16x16 top down characters pixel art/character 2/16x16 top down character 2-3.png"),
	preload("res://character/16x16 top down characters pixel art/character 3/16x16 top down character 3-3.png"),
	preload("res://character/16x16 top down characters pixel art/character 4/16x16 top down character 4-1.png"),
	preload("res://character/16x16 top down characters pixel art/character 5/16x16 top down character 5-2.png"),
	preload("res://character/16x16 top down characters pixel art/character 6/16x16 top down character 6-1.png"),
	preload("res://character/16x16 top down characters pixel art/character 7/16x16 top down character 7-1.png"),
	preload("res://character/16x16 top down characters pixel art/character 8/16x16 top down character 8-2.png"),
	preload("res://character/16x16 top down characters pixel art/character 9/16x16 top down character 9-2.png"),
	preload("res://character/16x16 top down characters pixel art/character 10/16x16 top down character 10-1.png"),
	preload("res://character/16x16 top down characters pixel art/character 3/16x16 top down character 3-2.png"),
]
var index_selection = 3
var char_potrait

func _ready() -> void:
	char_potrait = $Sprite2D
	update_potrait(index_selection)
	
func update_potrait(index):
	char_potrait.texture = characters[index]
	

func _on_right_pressed() -> void:
	if(index_selection < characters.size()-1):
		index_selection +=1
	update_potrait(index_selection)



func _on_left_pressed() -> void:
	if(index_selection > 0):
		index_selection -=1
	update_potrait(index_selection)

extends CanvasLayer

const characters = [
	preload("res://character/16x16 top down characters pixel art/character 1/16x16 top down character 1-1.png"),
	preload("res://character/16x16 top down characters pixel art/character 5/16x16 top down character 5-2.png"),
	preload("res://character/16x16 top down characters pixel art/character 4/16x16 top down character 4-2.png"),
	preload("res://character/16x16 top down characters pixel art/character 3/16x16 top down character 3-2.png"),
]
var index_selection = 3
var char_potrait

func _ready() -> void:
	char_potrait = $Sprite2D
	update_potrait(index_selection)
	
func update_potrait(index):
	char_potrait.texture = characters[index]
	
func _on_button_2_pressed() -> void:
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	pass # Replace with function body.

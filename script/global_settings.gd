extends Node

signal brightness_updated(value)
signal bloom_toggled(value)
signal selected_character_changed

var selected_character = 0
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

func update_brightness(value):
	emit_signal("brightness_updated", value)
	
func toggle_bloom(value):
	emit_signal("bloom_toggled", value)

extends Node2D

var character_skin

func _ready() -> void:
	character_skin = $CharacterBody2D/Sprite2D
	character_skin.texture = GlobalSettings.characters[GlobalSettings.selected_character]
	
func update_potrait(index: int):
	character_skin.texture = GlobalSettings.characters[index]

extends CanvasLayer

class_name BulletHell

@onready var pointer: TextureRect = $Pointer

@onready var selector_positions = [
	$SelectorPositions/HaruniPosition,
	$SelectorPositions/IpangPosition,
	$SelectorPositions/MiloPosition,
	$SelectorPositions/ArzimPosition
]

var current_index = 0

func _ready() -> void:
	pointer.position = selector_positions[0].position
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("up"):
		if current_index == 0:
			return
		current_index -= 1
		
		var tween = get_tree().create_tween()
		tween.tween_property(pointer, "position", selector_positions[current_index].position, .5)
		
	elif Input.is_action_just_pressed("down"):
		if current_index == selector_positions.size()-1:
			return
		current_index += 1
		
		var tween = get_tree().create_tween()
		tween.tween_property(pointer, "position", selector_positions[current_index].position, .5)
		
	elif Input.is_action_just_pressed("ui_accept"):
		GameConfigBullet.player_type = GameConfigBullet.PlayerType.values()[current_index]
		get_tree().change_scene_to_file("res://scene/level_selection.tscn")
		

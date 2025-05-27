extends Panel
@onready var inv_ui : Control =  $"../../.."
@onready var inv : Inv = load("res://inventory/player_inventory.tres")
@onready var item_visual : Sprite2D = $CenterContainer/Panel/item_display
@onready var choices = $VBoxContainer
signal interact(item_index:int)
##var toggle : bool = false
#var is_interacted : bool = false
@export var item_index: int 
func update(item:InvItem):
	if !item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = item.texture
	



func _on_interact_pressed() -> void:
	

			

	inv_ui.selected_items = item_index

	interact.emit(item_index)

	print(inv_ui.selected_items )

extends Panel
@onready var inv_ui : Control =  $"../../.."
@onready var inv : Inv = load("res://inventory/player_inventory.tres")
@onready var item_visual : Sprite2D = $CenterContainer/Panel/item_display
@onready var choices = $VBoxContainer
#signal interact(slot_order)
var toggle : bool = false
var is_interacted : bool = false

func update(item:InvItem):
	if !item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = item.texture
	



func _on_interact_pressed() -> void:
	var slot_order = get_parent().find_child(self.name).get_index()
	if toggle or (inv_ui.selected_items != slot_order and is_interacted):
		toggle = false
		is_interacted = false
		inv_ui.selected_items = 999
			
			
		
	elif !toggle and inv.items[slot_order] != null:
		
		inv_ui.selected_items = slot_order
		toggle = true
		is_interacted = true
		#choices.hide()ddddddd
	print(slot_order)
	print(inv_ui.selected_items )
	print(toggle)

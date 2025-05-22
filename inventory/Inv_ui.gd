extends Control
var is_interact : bool = false
var is_open : bool = false
var selected_items : int
@onready var choices =  $NinePatchRect/choices
@onready var inv : Inv = preload("res://inventory/player_inventory.tres")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#inv.clear()
	inv.update.connect(update_slots)
	update_slots()
	close()
	
	pass # Replace with function body.

func update_slots():
	#print("add plss")
	for i in range(min(inv.items.size(),slots.size())):
		slots[i].update(inv.items[i])
		

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()
	if is_open:
		for i in range(min(inv.items.size(),slots.size())):
			if slots[i].is_interacted:
				#selected_items = i
				#print('interacted')\
				choices.show()
				$NinePatchRect/choices/Label.text = inv.items[i].name
				
				#print(selected_items)
		if selected_items > 12:
			choices.hide()
		
			
func close():
	selected_items = 999
	self.visible = false
	is_open = false
	

func open():
	
	self.visible = true
	#self.grab_focus()
	for i in slots:
		i.grab_focus()
		#i.grab_click_focus()
	is_open = true


func _on_throw_pressed() -> void:
	if selected_items < 12:
		slots[selected_items].is_interacted = false
		slots[selected_items].toggle = false
		inv.throw(selected_items,inv.items[selected_items])
		selected_items = 999
	

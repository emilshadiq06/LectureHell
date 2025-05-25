extends Control
var is_interact : bool = false
var is_open : bool = false
var selected_items : int
@onready var deequip =  $NinePatchRect/equipmentChoice
@onready var choices =  $NinePatchRect/choices
@onready var inv : Inv = preload("res://inventory/player_inventory.tres")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()
@onready var equip_slots : Array = $NinePatchRect/equipment.get_children()
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
	for i in range(min(inv.items.size()-12,equip_slots.size())):
		equip_slots[i].update(inv.items[i+12])

func _process(delta: float) -> void:
	#print(selected_items)
	if Input.is_action_just_pressed("inventory") and get_parent().name != "CanvasLayer":
		if is_open:
			close()
		else:
			open()
	if is_open:
		for i in range(min(inv.items.size(),slots.size())):
			if slots[i].is_interacted and selected_items < 12:
				choices.show()
				
				$NinePatchRect/choices/Label.text = inv.items[i].name
		for i in range(min(inv.items.size()-12,equip_slots.size())):
			if equip_slots[i].is_interacted and selected_items < 15:
				deequip.show()
				
		if selected_items > 11:
			choices.hide()
		if selected_items > 14:
			deequip.hide()
		
		
			
func close():
	print("vvvv")
	selected_items = 999
	self.visible = false
	is_open = false
	

func open():
	print("bbbb")
	self.visible = true
	is_open = true


func _on_throw_pressed() -> void:
	var target = get_parent()
	if selected_items < 12 and target.name=="Player":
		slots[selected_items].is_interacted = false
		slots[selected_items].toggle = false
		inv.throw(selected_items,inv.items[selected_items])
		selected_items = 999
	


func _on_use_pressed() -> void:
	#var is_battle:bool = false
	#var battle:String = get_tree().current_scene.get_path()
	var target = get_parent()
		
		
		
	if selected_items < 12:
		var item_picked:int = selected_items
		print(selected_items)
		slots[selected_items].is_interacted = false
		slots[selected_items].toggle = false
		if target.name != "Player":
			var player_group = $"../../PlayerGroup"
			
			if inv.items[item_picked] is consumable:
				target = player_group.players[player_group.index]
				player_group._on_brace_pressed()
				player_group._on_back_pressed()
			elif inv.items[item_picked] is expendable:
				if  inv.items[item_picked].use_onEnemy:
					target = $"../../EnemyGroup".enemies[randi() % $"../../EnemyGroup".enemies.size()]
				player_group._on_brace_pressed()
				player_group._on_back_pressed()
		inv.use(item_picked,inv.items[item_picked],target)
		selected_items = 999
 


func _on_deequip_pressed() -> void:
	var target = get_parent()
	if selected_items < 15 and target.name == "Player":
		if selected_items == 12:
			target.change_stat(20,20)
		elif selected_items == 13:
			target.change_weapon(1,1)
		equip_slots[selected_items-12].is_interacted = false
		equip_slots[selected_items-12].toggle = false
		inv.insert(inv.items[selected_items])
		inv.throw(selected_items,inv.items[selected_items])
		selected_items = 999
	#pass # Replace with function body.

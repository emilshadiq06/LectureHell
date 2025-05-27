extends Resource
class_name Inv
signal update
var using_items:InvItem
@export var items : Array[InvItem]

var scene : String
func insert(item: InvItem):
	var empty_index : int = 999
	#print("add")
	for i in range(items.size()-2):
		if items[i] == null:
			empty_index = i
			break
	if empty_index < 12:
		items[empty_index]= item
		update.emit()
	#var emptyslots = items.filter(func(item): return item==null)
	#if !emptyslots.is_empty():
		
	#	emptyslots[0]=item
		print(items)
func find(item:InvItem):
	var full_list : Array[int]
	
	for i in range(items.size()-2):
		if items[i] != null and items[i].name == (item.name):
			#print(items[i].name)
			#print(item_name)
			
			full_list.append(i)
				#print(full_index)
				#print(item_name)
	return full_list
	
		
	
func throw(index:int,item:InvItem):
	if items[index] == item:
		items[index] = null
		print(items)
		print(items.size())
	update.emit()
	
func use(index:int,item:InvItem,target:Node):
	#using_items = index
	var remove : bool = false

	if (item is consumable or item is expendable)  and item.lose_on_use:
		#item.item_used.connect(on_item_used) #inv.update.connect(update_slots)
		remove = true
	elif item is equipment and target.name == "Player":
		item.item_equip.connect(item_equip)
		remove = true
		#throw(index,item)
	if items[index] == item:
		item.use(target)
	update.emit()
	if remove:
		throw(index,item)
	
func item_equip(itemUsed:equipment):
	var equip_index : int = 12
	if itemUsed is weapon:
		equip_index = 13
	#using_items = itemUsed
	
	if items[equip_index] != null:
		var moving_item = items[equip_index]
		insert(moving_item.duplicate())
	items[equip_index] = itemUsed
	update.emit()

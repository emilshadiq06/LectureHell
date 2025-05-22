extends Resource
class_name Inv
signal update
@export var items : Array[InvItem]

var scene : String
func insert(item: InvItem):
	var empty_index : int = 0
	#print("add")
	for i in range(items.size()):
		if items[i] == null:
			empty_index = i
			break
	
	items[empty_index]= item
	#var emptyslots = items.filter(func(item): return item==null)
	#if !emptyslots.is_empty():
		
	#	emptyslots[0]=item
	print(items)
	update.emit()

func throw(index:int,item:InvItem):
	if items[index] == item:
		items[index] = null
		print(items)
		print(items.size())
	update.emit()
	
func use(index:int,item:InvItem,target:Node):
	if items[index] == item:
		item.use(target)
	if item is consumable and item.lose_on_use:
		item.item_used.connect(on_item_used) #inv.update.connect(update_slots)
		throw(index,item)


	update.emit()
	
func on_item_used(itemUsed:InvItem,used:bool):
	pass

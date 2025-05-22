extends Resource
class_name Inv
signal update
@export var items : Array[InvItem]

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

func throw(index:int,item):
	if items[index] == item:
		items[index] = null
		print(items)
		print(items.size())
	update.emit()

func clear():
	for i in range(items.size()):
		if items[i] != null and items[i].name == "":
			items[i]=null

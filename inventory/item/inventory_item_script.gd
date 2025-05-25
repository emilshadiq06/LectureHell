extends Resource
class_name InvItem
#signal item_used(item_resource)
@export var name: String = ""
@export var texture: Texture2D

func use(target):
	#emit_signal("item_used",self)
	
	pass

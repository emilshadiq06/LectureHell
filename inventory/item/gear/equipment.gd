extends InvItem

class_name equipment
signal item_equip(iten:equipment)
#@export var lose_on_use : bool
@export var hp_changed : int
@export var pp_changed : int

#var target = stat

func use(target):
	if target.name == ("Player"):
		#print("sop")
		target.change_stat( hp_changed, pp_changed)
		item_equip.emit(self)
	
	pass

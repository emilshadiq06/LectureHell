extends InvItem

class_name equipment
signal item_equip(iten:equipment)
#@export var lose_on_use : bool
@export var hp_changed : int
@export var pp_changed : int
@export var walk_changed : float = 250
@export var dash_window_changed : float = 0.1
#var target = stat

func use(target):
	if target.name == ("Player"):
		#print("sop")
		target.change_stat( hp_changed, pp_changed,walk_changed,dash_window_changed)
		item_equip.emit(self)
	
	pass

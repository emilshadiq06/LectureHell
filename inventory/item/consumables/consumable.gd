extends InvItem
class_name consumable
signal item_used(iten:InvItem,used:bool)
@export var lose_on_use : bool
@export var hp_regen : int
@export var pp_regen : int
@export var bites : int

#var target = stat

func use(target):
	if !lose_on_use:
		bites -= 1
	if bites <= 1:
		lose_on_use = true
	target.addhealth(hp_regen,pp_regen)
	item_used.emit(self,lose_on_use)
	
	
	pass

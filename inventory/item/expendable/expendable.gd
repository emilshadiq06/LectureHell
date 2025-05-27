extends InvItem
class_name expendable

signal item_used(iten:InvItem,used:bool)
@export var lose_on_use : bool
@export var use_onSelf: bool
@export var use_onEnemy: bool
@export var hp_loss : int
@export var stats_change : float
#@export var pp_loss : int

#var target = stat

func use(target):
	if use_onEnemy:
		target.removehealth(hp_loss)
	elif use_onSelf:
		target.change_stat(stats_change)
	item_used.emit(self,lose_on_use)
	pass

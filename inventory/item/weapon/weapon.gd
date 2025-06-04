extends equipment
class_name weapon

@export var weapon_arrow : Array[Array]
#@export var weapon_speed : float

func use(target):
	if target.name == ("Player"):
		#print("sop")
		target.change_weapon(weapon_arrow)
		item_equip.emit(self)
	
	pass

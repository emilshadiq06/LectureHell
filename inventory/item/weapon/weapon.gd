extends equipment
class_name weapon

@export var weapon_arrow : int
@export var weapon_speed : float

func use(target):
	if target.name == ("Player"):
		#print("sop")
		target.change_weapon(weapon_arrow,weapon_speed)
		item_equip.emit(self)
	
	pass

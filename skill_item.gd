extends InvItem
class_name skill_item
signal skill_obtained(iten:skill_item)
var lose_on_use: bool = false
@export var skill : String

func use(target):
	
		
	if target.name == ("Player"):
		
		print("sop")
		target.addskill(skill,self)
		skill_obtained.emit(self)

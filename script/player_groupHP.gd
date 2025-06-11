extends Control
var index : int = 0
var skill_index : int = 999
@export var player_stat : stat
@onready var player_team = $group/Player
@onready var team = $group.get_children()

@onready var skillui =$skillnstuff/ScrollContainer/skill
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	
	update_group(player_stat,index)
	
	StatLoader.update_group.connect(update_group)
	for i in range(StatLoader.player_group.size()):
		update_group(StatLoader.player_group[i].stats,i+1)
		team[i+1].show()
	for i in range(skillui.get_children().size()-1):
		skillui.get_child(i+1).item_pos.connect(_skill_button_pressed)
		#skill2.item_pos.connect(_skill_button_pressed)


func update_group(member_stats:stat,member_index:int):
	$skillnstuff/SkillInteract.hide()
	skillui.hide()
	team[member_index].get_node("stats").get_child(1).text = member_stats.name
	team[member_index].get_node("stats").get_child(2).text = ("HP" + str(member_stats.hp) +"/" +str(member_stats.max_hp))
	team[member_index].get_node("stats").get_child(0).value = (member_stats.hp*100/member_stats.max_hp)
	team[member_index].show()
	#index += 1`
	#pass


func _on_button_pressed() -> void:
	index = 0
	skillui.show()
	for i in range($skillnstuff/skills.get_children().size()):
		$skillnstuff/skills.get_child(i).set_script(null)
		skillui.get_child(i+1).text = ""
	for i in range(player_stat.skill.size()):
		$skillnstuff/skills.get_child(i).set_script(load(player_stat.skill[i].skill))
		$skillnstuff/skills.get_child(i)._ready()
		skillui.get_child(i+1).text = $skillnstuff/skills.get_child(i).skill_name
	$skillnstuff.position.x = team[index].position.x*250*index
	if $skillnstuff/SkillInteract/description/MarginContainer.visible == true:
		$skillnstuff/SkillInteract/description/MarginContainer.hide()
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	index = 1 #StatLoader.player_group[i].stats,i+1)
	skillui.show()
	for i in range($skillnstuff/skills.get_children().size()):
		$skillnstuff/skills.get_child(i).set_script(null)
		skillui.get_child(i+1).text = ""
	for i in range(StatLoader.player_group[index-1].stats.skill.size()):
		$skillnstuff/skills.get_child(i).set_script(load(StatLoader.player_group[index-1].stats.skill[i].skill))
		$skillnstuff/skills.get_child(i)._ready()
		skillui.get_child(i+1).text = $skillnstuff/skills.get_child(i).skill_name
	$skillnstuff.position.x = team[0].position.x*250*index
	if $skillnstuff/SkillInteract/description/MarginContainer.visible == true:
		$skillnstuff/SkillInteract/description/MarginContainer.hide()
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	index = 2
	skillui.show()
	for i in range($skillnstuff/skills.get_children().size()):
		$skillnstuff/skills.get_child(i).set_script(null)
		skillui.get_child(i+1).text = ""
	for i in range(StatLoader.player_group[index-1].stats.skill.size()):
		$skillnstuff/skills.get_child(i).set_script(load(StatLoader.player_group[index-1].stats.skill[i].skill))
		$skillnstuff/skills.get_child(i)._ready()
		skillui.get_child(i+1).text = $skillnstuff/skills.get_child(i).skill_name
	$skillnstuff.position.x = team[0].position.x*250*index
	if $skillnstuff/SkillInteract/description/MarginContainer.visible == true:
		$skillnstuff/SkillInteract/description/MarginContainer.hide()
	pass # Replace with function body.



#func _on_visibility_changed() -> void:
	
	
	#for i in range(StatLoader.player_group.size()):
		#update_group(StatLoader.player_group[i].stats,)
		#team[index].show()
		
	#index = 1
	#pass # Replace with function body.


func _on_draw() -> void:
	for i in team:
		print("mimimimininininini")
		var j = i.get_child(1)
		if j is Button:
				j.grab_focus()
				



func _on_hidden() -> void:
	for i in team:
		print("mimimimi")
		var j = i.get_child(1)
		if j is Button:
			j.release_focus()
				
func _skill_button_pressed(item_pos:int):
	if skill_index == 999:
		skill_index = item_pos
		$skillnstuff/SkillInteract.show()
		if $skillnstuff/SkillInteract/description/MarginContainer.visible == true:
			$skillnstuff/SkillInteract/description/MarginContainer.hide()
	else:
		
		skill_index = 999
		$skillnstuff/SkillInteract.hide()
	pass


func _on_description_pressed() -> void:
	if skill_index < 999:
		$skillnstuff/SkillInteract/description/MarginContainer.show()
		if $skillnstuff/skills.get_child(skill_index).get_script()!=null:
			$skillnstuff/SkillInteract/description/MarginContainer/Label.text = $skillnstuff/skills.get_child(skill_index).skill_desc
		
	else:
		$skillnstuff/SkillInteract/description/MarginContainer.hide()
		$skillnstuff/SkillInteract/description/MarginContainer/Label.text = ""


func _on_remove_pressed() -> void:
	if skill_index < 999:
		
		if index == 0 and $skillnstuff/skills.get_child(skill_index).get_script()!=null:
			skillui.hide()
			$skillnstuff/SkillInteract.hide()
			if $"../..".find_item(null).size()==0:
				$"../..".inv.throw(0, $"../..".inv.items[0])
			$"../..".inv.insert(player_stat.skill[skill_index])
			player_stat.skill.remove_at(skill_index)
			$skillnstuff/skills.get_children()[skill_index].set_script(null)
			$skillnstuff/SkillInteract/description/MarginContainer/Label.text = ""
			skillui.get_child(skill_index+1).text = ""
			
		elif  index != 0 and skill_index == 1 and $skillnstuff/skills.get_child(skill_index).get_script()!=null:
			skillui.hide()
			$skillnstuff/SkillInteract.hide()
			if $"../..".find_item(null).size()==0:
				$"../..".inv.throw(0, $"../..".inv.items[0])
			
			$"../..".inv.insert(StatLoader.player_group[index-1].stats.skill[skill_index])
			StatLoader.player_group[index-1].stats.skill.remove_at(skill_index)
			$skillnstuff/skills.get_children()[skill_index].set_script(null)
			$skillnstuff/SkillInteract/description/MarginContainer/Label.text = ""
			skillui.get_child(skill_index+1).text = ""
		elif index != 0 and skill_index == 0 and $skillnstuff/skills.get_child(skill_index).get_script()!=null:
			$skillnstuff/SkillInteract/description/MarginContainer.show()
			$skillnstuff/SkillInteract/description/MarginContainer/Label.text = "cant remove skill"
		
	pass # Replace with function body.

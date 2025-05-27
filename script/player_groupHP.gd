extends Control
var index : int = 0

@export var player_stat : stat
@onready var player_team = $group/Player
@onready var team = $group.get_children()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	update_group(player_stat,index)
	
	StatLoader.update_group.connect(update_group)
	for i in range(StatLoader.player_group.size()):
		update_group(StatLoader.player_group[i].stats,i+1)
		team[i+1].show()



func update_group(member_stats:stat,member_index:int):
	
	
	team[member_index].get_node("stats").get_child(1).text = member_stats.name
	team[member_index].get_node("stats").get_child(2).text = ("HP" + str(member_stats.hp) +"/" +str(member_stats.max_hp))
	team[member_index].get_node("stats").get_child(0).value = (member_stats.hp*100/member_stats.max_hp)
	team[member_index].show()
	#index += 1`
	#pass


func _on_button_pressed() -> void:
	index = 0
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	index = 1
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	index = 2
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
				

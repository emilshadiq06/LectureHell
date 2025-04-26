extends Node
var index : int = 0
var players: Array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	players = get_children()
	for i in players.size():
		players[i].position =  Vector2(0,100*i)

	players[0]._focus()


func _on_enemy_group_next_player() -> void:
	if index < players.size()-1:
		index += 1
		switch_focus(index,index-1)

	else:
		index = 0
		switch_focus(index,players.size()-1)



	
func switch_focus(x,y):
	players[x]._focus()
	players[y]._unfocus()

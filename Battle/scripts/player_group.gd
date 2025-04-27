extends Node
var index : int = 0
var players: Array = []
@onready var bullet_hell_timer =  $"../BulletHellTimer"
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


func _on_enemy_group_bullet_hell() -> void:
	bullet_hell_timer.start(2)
	
func start_hell():
	if bullet_hell_timer.get_time_left() > 0:
		DialogueManagerScript.start_dialog(Vector2(200,200), ["bullet hell goes here"])
	#add_child(bullet_hell)
	
func _process(delta: float) -> void:
	start_hell()
	if bullet_hell_timer.get_time_left() < 0:
		#remove_child(bullet_hell)
		pass

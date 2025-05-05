extends Node
@onready var attack_scene = preload("res://Battle/attack.tscn")
@onready var player_group = load("res://Battle/player_group.tscn").instantiate()
@onready var choice = $"../CanvasLayer/choice"
var players : Array = []
var action_queue : Array = []
var attack 
var ball_index : int = 0
var hits : int = 0
var is_battling: bool = false
signal bullet_hell 
signal next_player

var enemies: Array = []

var index: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	await get_tree().create_timer(0.05).timeout
	players = player_group.get_children()
	enemies = get_children()
	for i in enemies.size():
		enemies[i].position =  Vector2(0,100*i)

	_start_choosing()

func add_character():
	
	var new_char = get_node("Character").duplicate()
	add_child(new_char)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_battling == false:
		if Input.is_action_just_pressed("up"):
			if index > 0:
				index -= 1
				switch_focus(index,index+1)
		elif Input.is_action_just_pressed("down"):
			if index < enemies.size()-1:
				index += 1
				switch_focus(index,index-1)
		if Input.is_action_just_pressed("advance_dialog"):
			emit_signal("next_player")
			action_queue.push_back(index)
			if action_queue.size() < players.size():
				show_choice()
			
	if action_queue.size() == players.size() and not is_battling:
		is_battling = true
		_action(action_queue) 
		




func _action(stack):
	
	for i in stack:
		
		attack = attack_scene.instantiate()
		attack.position = Vector2(0,-150)
		attack.finish.connect(_on_moves_finish) 
	#	print("here")
	#	print(players[i].weapon)
		attack.get_node("Balls").add_ball(players[i].weapon)
		add_child(attack)
		
		await get_tree().create_timer(2.4).timeout
		remove_child(attack)
		enemies[i].take_damage(2*hits)
		ball_index = 0
		
	
	action_queue.clear()
	bullet_hell.emit()
		



func switch_focus(x,y):
	enemies[x]._focus()
	enemies[y]._unfocus()

func show_choice():
	choice.show()
	choice.find_child("attack").grab_focus()

func _reset_focus():
	index = 0
	for enemy in enemies:
		enemy._unfocus()

func _start_choosing():
	_reset_focus()
	enemies[0]._focus()
	
	
func _on_attack_pressed() -> void:
	
	if is_battling == false:
		choice.hide()
		_start_choosing()

func _on_moves_finish()-> bool:

	ball_index = attack.get_ball_index()
	hits =  attack.get_ball_hit()
#	print(ball_index)
#	print(hits)
	return true
	


func _on_bullet_hell_timer_timeout() -> void:
	
	_reset_focus()
	action_queue.clear()
	is_battling = false
	show_choice()

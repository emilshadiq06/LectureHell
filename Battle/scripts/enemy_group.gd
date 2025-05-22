extends Node
@onready var attack_scene = preload("res://Battle/attack.tscn")
@onready var player_group = $"../PlayerGroup"#  load("res://Battle/player_group.tscn").instantiate()
@onready var choice = $"../CanvasLayer/choice"
@onready var attkChoice = $"../CanvasLayer/attackChoice"
@onready var actChoice = $"../CanvasLayer/actChoice"
var damage_multiplier = 1
var crit_list : Array = []
var crit : bool = false
var players : Array = []
var weapons : Array = []
var action_queue : Array
var attack 
var ball_index : int = 0
var hits : int = 0
var is_battling: bool = false
signal bullet_hell 
signal next_player
signal start_turn
var enemies: Array = []

var index: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	#await get_tree().create_timer(3).timeout
	#player_group.instantiate()
	players = player_group.get_children()
	enemies = get_children()
	remove_child(enemies[0])
	enemies.remove_at(0)
	for i in enemies.size():
		enemies[i].position =  Vector2(0,100*i)

	_start_choosing()

func add_character():
	
	var new_char = get_node("Character").duplicate()
	add_child(new_char)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("action_queue")
	#print(action_queue)
	if is_battling == false and actChoice.visible == false and attkChoice.visible == false and choice.visible == false:

		if Input.is_action_just_pressed("up"):
			if index > 0:
				index -= 1
				switch_focus(index,index+1)
		elif Input.is_action_just_pressed("down"):
			if index < enemies.size()-1:
				index += 1
				switch_focus(index,index-1)
		if Input.is_action_just_pressed("chat"):
			weapons.push_back(players[player_group.index].weapon)
			emit_signal("next_player")
			action_queue.push_back(index)
			if crit == true:
				crit_list.push_back(index)
				crit = false
			if action_queue.size() < players.size():
				show_choice()


			
	if action_queue.size() >= players.size() and not is_battling:
			is_battling = true
			_action(action_queue) 
		




func _action(stack):
	print("stack")
	print(stack)
	var j : int = 0
	for i in stack:
		if i is int:
			attack = attack_scene.instantiate()
			attack.position = Vector2(0,-150)
			if i in crit_list:
				print("crit here")
			var balls = attack.get_node("Balls")
		#balls.send_result.connect(_on_balls_send_result) 
		#print("here1")
		#print("here2")
		#print(players[player_group.index].weapon)
		#print("here3")
			attack.get_node("Balls").add_ball(weapons[j])
			
			add_child(attack)
			await get_tree().create_timer(2).timeout
			ball_index = attack.get_ball_index()
			hits =  attack.get_ball_hit()
		
		
			remove_child(attack)
			enemies[i].take_damage(4*damage_multiplier*hits/(weapons[j] +1))
			j+=1
		
			ball_index = 0
	weapons.clear()
	crit_list.clear()
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
	#print(action_queue)
	#if is_battling == false:
	choice.hide()
	attkChoice.show()
		#_start_choosing()




func _on_bullet_hell_timer_timeout() -> void:
	DialogueManagerScript.text_box.queue_free()
	DialogueManagerScript.is_dialog_active = false
	DialogueManagerScript.current_line_index = 0
	start_turn.emit()
	_reset_focus()
	#action_queue.clear()
	is_battling = false
	show_choice()


func _on_normal_attack_pressed() -> void:
		
	if players[player_group.index].pp >= 5:
		print(players[player_group.index].pp)
		attkChoice.hide()
		_start_choosing()
		players[player_group.index].take_stamina(5)
	


func _on_critical_attack_pressed() -> void:
	if players[player_group.index].pp >= 10:
		#print(players[player_group.index].pp)
		attkChoice.hide()
		_start_choosing()
		crit = true
		players[player_group.index].take_stamina(10)

		
	


func _on_back_pressed() -> void:
	
	choice.show()
	attkChoice.hide()
	

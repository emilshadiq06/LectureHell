extends Node

var players : Array = []
var action_queue : Array = []
var is_battling: bool = false
@onready var player_group = $"../PlayerGroup"
@onready var choice = $"../CanvasLayer/choice"
signal next_player

var enemies: Array = []

var index: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	players = player_group.get_children()
	enemies = get_children()
	for i in enemies.size():
		enemies[i].position =  Vector2(0,100*i)

	_start_choosing()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not choice.visible:
		if Input.is_action_just_pressed("up"):
			if index > 0:
				index -= 1
				switch_focus(index,index+1)
		elif Input.is_action_just_pressed("down"):
			if index < enemies.size()-1:
				index += 1
				switch_focus(index,index-1)
		if Input.is_action_just_pressed("left"):
			emit_signal("next_player")
			action_queue.push_back(index)
			show_choice()
			
	if action_queue.size() == players.size() and not is_battling:
		is_battling = true
		_action(action_queue) 

func _action(stack):
	for i in stack:
		enemies[i].take_damage(1)
		await get_tree().create_timer(1).timeout
	action_queue.clear()
	is_battling = false
	show_choice()


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
	choice.hide()
	_start_choosing()

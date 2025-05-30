extends Node
var in_damage_multiplier : float = 1
var index : int = 0
var players: Array = []
@onready var enemies = $"../EnemyGroup"
@onready var choice = $"../CanvasLayer/choice"
@onready var actChoice = $"../CanvasLayer/actChoice"
@onready var inventory = $"../CanvasLayer/inventory"
var stage = load("res://Battle/stage.tscn").instantiate()
@onready var effect_machine = $"../effectMachine"
@onready var bullet_hell_timer =  $"../BulletHellTimer"

@export var inv: Inv

var skill_button
var effect_array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	players = get_children()
	for i in range(players.size()):
		players[i].position =  Vector2(0,130*i)
		players[i].sprite.set_frame(15)
		players[i].sprite.scale.x = -1
		effect_array.push_back(players[i].get_node("skill"))
		#print(players[i].get_node("skill").skill_name)
		
	skill_button = Button.new()
	skill_button.pressed.connect(_skill_button_pressed)
#print(effect_array)
	players[0]._focus()


func add_character():
	
	var new_char = get_node("Character").duplicate()
	add_child(new_char)
func _skill_button_pressed():
	if effect_array[index].get_skill_effects() not in effect_machine.origin:
		
		
		effect_machine.add_child(effect_array[index].duplicate())
		actChoice.hide()
		effect_machine.initialize()
	else:
		DialogueManagerScript.start_dialog(Vector2(300,500), ["effect is on cooldown"])
		#print(effect_machine.origin)
	
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
	enemies.choice.hide()
	var duration: float
	get_parent().add_child(stage) 
	await get_tree().create_timer(1).timeout
	for i in enemies.enemies:
		if i.hp>0:
			var attack
			if i.randomize:
				
				attack = load(i.attk_str[randi() % i.attk_str.size()]).instantiate()
			else:
				attack = load(i.attk_str[ceil((i.hp/i.MAX_HP)*i.attk_str.size())-1]).instantiate()
			var attk_dmg = attack.get_children()

			duration += i.attk_duration
			duration /= enemies.enemies.size()
			stage.add_child(attack)
			await get_tree().create_timer(0.5).timeout
	
	
	bullet_hell_timer.start(duration)



func _on_act_pressed() -> void:
	#var battle = get_tree().current_scene.get_path()
	
	#print(battle)
	choice.hide()

	skill_button.text = effect_array[index].get_skill_effects()[0]
	actChoice.get_child(0).add_child(skill_button)
	actChoice.show()


func _on_back_pressed() -> void:
	if inventory.is_open:
		inventory.close()
	else:
		actChoice.hide()
	choice.show()


func play_dance():
	
	players[index]._play_animation("dance")

func stop_anim(i):
	players[i]._stop_animation()


func _on_brace_pressed() -> void:
	
	enemies.action_queue.push_back("null")
	actChoice.hide()
	#if inventory.is_open:
	#	inventory.close()
	#if enemies.action_queue.size() < players.size():
	enemies.next_player.emit()
	enemies.show_choice()
	
	pass # Replace with function body.


func _on_enemy_group_start_turn() -> void:
	#print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSS")
	#print(enemies.action_queue)
	for i in players:
		#i.take_damage(2)
		i.take_stamina(-2)
		if i.pp > i.MAX_PP:
			i.pp -= 4
			if i.pp < i.MAX_PP:
				i.pp =  i.MAX_PP 
		if i.hp > i.MAX_HP:
			i.hp -= 4
			if i.hp < i.MAX_HP:
				i.hp =  i.MAX_HP 
		
	#	print(i.pp)


func _on_item_pressed() -> void:
	choice.hide()

	if !inventory.is_open:
		inventory.open()
		
	
		
	
	 # Replace with function body.

extends Node
var index : int = 0
var players: Array = []
@onready var enemies = $"../EnemyGroup"
@onready var choice = $"../CanvasLayer/choice"
@onready var actChoice = $"../CanvasLayer/actChoice"
signal start_turn
@onready var effect_machine = $"../effectMachine"
@onready var bullet_hell_timer =  $"../BulletHellTimer"
var skill_button
var effect_array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	players = get_children()
	for i in players.size():
		players[i].position =  Vector2(0,100*i)
		effect_array.push_back(players[i].get_node("skill"))
		
		#print(players[i].get_node("skill").new_skill.get_skill_effects())

		
	skill_button = Button.new()
	skill_button.pressed.connect(_skill_button_pressed)
#print(effect_array)


	players[0]._focus()
	
func _skill_button_pressed():
	if effect_array[index].get_skill_effects() not in effect_machine.origin:
		
		enemies.action_queue.push_back("null")
		effect_machine.add_child(effect_array[index].duplicate())
		actChoice.hide()
		effect_machine.initialize()
	else:
		DialogueManagerScript.start_dialog(Vector2(300,500), ["effect is on cooldown"])
		#print(effect_machine.origin)
	
func _on_enemy_group_next_player() -> void:
	if index == 0:
		start_turn.emit()
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
	
	
	bullet_hell_timer.start(4)
	
func start_hell():
	if bullet_hell_timer.get_time_left() > 0:
		DialogueManagerScript.start_dialog(Vector2(300,500), ["bullet hell goes here"])
	#add_child(bullet_hell)
	
func _process(delta: float) -> void:
	start_hell()
	if bullet_hell_timer.get_time_left() < 0:
		#remove_child(bullet_hell)
		pass


func _on_act_pressed() -> void:
	
	choice.hide()
	
	
	skill_button.text = effect_array[index].get_skill_effects()[0]
	actChoice.add_child(skill_button)
	actChoice.show()


func _on_back_pressed() -> void:
	
	choice.show()
	actChoice.hide()

func play_dance():
	players[index]._play_animation("dance")

func stop_anim():
	players[index]._stop_animation()


func _on_brace_pressed() -> void:
	enemies.action_queue.push_back("null")
	actChoice.hide()
	pass # Replace with function body.

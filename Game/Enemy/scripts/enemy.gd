class_name Enemy extends CharacterBody2D
@onready var player = get_node("../Player")
@onready var state_machine  = $EnemyStateMachine
@onready var fight = preload("res://Battle/battle.tscn").instantiate()
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

const SPEED = 100.0
var chase_dir : Vector2
var chase : bool = false 

func _ready() -> void:
	state_machine.initialize(self)
	#direction.y = 1
	pass # Replace with function body.

func _process(delta: float) -> void:
	if chase == true:
		chase_dir = (player.position-position).normalized()
	pass
	
func _physics_process(delta: float) -> void:

	move_and_slide()
	


func choose_randomly(list_of_entries):
	return list_of_entries[randi() % list_of_entries.size()]
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		DialogueManagerScript.is_dialog_active = false
		DialogueManagerScript.current_line_index = 0
		var current_scene = get_tree().current_scene
		
		get_whole_group("enemies")
		var player_Battle = fight.get_node("PlayerGroup").get_node("Character")
		player_Battle.add_child(body.get_node("skill").duplicate())
		player_Battle.set_stats(StatLoader.return_stats())
		StatLoader.get_skill(body.get_node("skill"))

		#print(StatLoader.return_skill().get_skill_effects())
		
		
		#print("here xoxo")
		#print(player_Battle.get_node("skill").update_skill())
		get_tree().get_root().add_child(fight)
		get_tree().current_scene = fight
		current_scene.queue_free()

func get_whole_group(group):
	if self.is_in_group(group):
		for i in get_tree().get_nodes_in_group(group).size()-1:
			var enemy_Battle = fight.get_node("EnemyGroup")
			enemy_Battle.add_character()
	
			
	

func _on_chase_area_body_entered(body) -> void:
	if body == player:
		chase = true

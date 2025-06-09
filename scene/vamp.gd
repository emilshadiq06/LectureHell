extends StaticBody2D

@export var stats : stat
@onready var dialogue_player = $Chat
@onready var animsprite = $AnimatedSprite
@onready var sprite = $Sprite2D
@onready var battlefr = $battle_teleport
@export var next_dialogue: Array[dialogue_lines]
@onready var bullethell = $Portal3
var player 
var chase: bool =  false
var finish: bool =  false
@export var dialoges: Dialogue = Dialogue.First
var group_str : String
#var change_to_last
#var current_dialogue : int = 0
# Called when the node enters the scene tree for the first time.

enum Dialogue{First,Sec,Third}
func _ready() -> void:
	animsprite.play("default")
	next_dialogue[0] = dialogue_player.dialogue  
	if self.name in StatLoader.dead_array:
		StatLoader.quest_array.append(next_dialogue[1].quest_name)
		
	

	
	while dialogue_player.dialogue.quest_name in StatLoader.quest_array: 


		
		if dialoges + 1 < next_dialogue.size():
			dialoges += 1
			print(next_dialogue[dialoges].quest_name)
			dialogue_player.dialogue = next_dialogue[dialoges]
			print(dialogue_player.dialogue.quest_name)
		else:
			break
	
	dialogue_player.dialog_branch.clear()
	dialogue_player.lines_array.clear()
	dialogue_player.dialogue.index = 0
		#dialogue_player.next_line()
	dialogue_player._ready()
	DialogueManagerScript.finish_lines.connect(next_line)
	

func next_line():
		player = dialogue_player.player
		match dialoges:
			Dialogue.First:
				dialogue_player.dialogue = next_dialogue[Dialogue.First]
				if  dialogue_player.dialogue.index == 0 and player != null:
					AudioPlayer.play_audio("res://sounds/woosh.wav")
					$"../ominousroom".hide()
					animsprite.show()
				elif  dialogue_player.dialogue.index == dialogue_player.dialogue.event_index:
					animsprite.play("aggro")
					var tween = get_tree().create_tween().bind_node(self)
					tween.tween_property(animsprite, "scale", Vector2(100,100), 0.2)
					tween.tween_property(animsprite, "position", position + Vector2.DOWN*500, 0.2)
					AudioPlayer.play_audio("res://sounds/explosion.mp3")
					#StatLoader.quest_array.append(dialogue_player.dialogue.quest_name)
					print(StatLoader.quest_array)
					await get_tree().create_timer(0.1).timeout
					bullethell.monitorable = true
					bullethell.monitoring = true
					
					#print('ok')
					#pass
			Dialogue.Sec:
				
				if  dialogue_player.dialogue.index == 0:
					AudioPlayer.play_audio("res://sounds/woosh.wav")
					$"../ominousroom".hide()
					animsprite.show()
				elif  dialogue_player.dialogue.index == dialogue_player.dialogue.event_index:
					animsprite.play("aggro")
					var tween = get_tree().create_tween().bind_node(self)
					tween.tween_property(animsprite, "scale", Vector2(100,100), 0.2)
					tween.tween_property(animsprite, "position", position + Vector2.DOWN*500, 0.2)
					AudioPlayer.play_audio("res://sounds/woosh.wav")
					chase = true
					battlefr.monitorable = true
					battlefr.monitoring = true
					StatLoader.quest_array.append(dialogue_player.dialogue.quest_name)
					#pass
			
			Dialogue.Third:
				

				$end.monitorable = true
				$end.monitoring = true

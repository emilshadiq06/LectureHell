
extends Player

@onready var player_team = $inventory/player_team_ui

@export var inv :Inv
@onready var skill = $skill

@export var stats : playerStat

func _ready() -> void:
	run = 1
	update_pos()
	$RichTextLabel.text =  "$" + str(stats.money)
	if StatLoader.skill_node != null:
		skill.set_script(StatLoader.return_skill().get_script())
		#StatLoader.skill_node = null
	state_machine.initialize(self)
	if StatLoader.was_just_inBattle == true:
		StatLoader.was_just_inBattle = false
		stats.money += StatLoader.money
		$RichTextLabel.text =  "$" + str(stats.money)
		print("KKKKKKKKKKKKKK")
		print(stats.money)
		position = StatLoader.previous_position
		
	pass # Replace with function body.






# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	doubletap_time -= delta
	direction = Vector2(Input.get_axis("left","right"),Input.get_axis("up","down")).normalized()

	pass
	
func _input(event: InputEvent):
	if Input.is_action_just_pressed("left")||Input.is_action_just_pressed("right")||Input.is_action_just_pressed("up")||Input.is_action_just_pressed("down") :
		
		if last_keycode == event.keycode and  doubletap_time >= 0 and doubletap_time < 0.2: 
			
			last_keycode = 0
			run = 2
	

		else:
			last_keycode = event.keycode
		
		doubletap_time = DOUBLETAP_DELAY

#func _physics_process(_delta: float) -> void:
	#move_and_slide()
	
#func SetDirection() -> bool:
#	var new_dir : Vector2 = cardinal_direction
#	if direction == Vector2.ZERO:

	#	return false
	#if direction.y == 0:
	#	new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	#elif direction.x == 0:
	#	new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	#if new_dir == cardinal_direction:
	#	return false
	#cardinal_direction = new_dir
	#sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	#return true
	
func get_stats():
	return stats


	#return [stats.hp, stats.weapon, stats.max_pp, stats.pp ,stats.max_hp ,stats.money]
	
func UpdateAnimation(state : String) -> void:
	animation_player.play(state + "_" + AnimDirect())
	pass

func AnimDirect() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func collect_item(item:InvItem):
	inv.insert(item)
func find_item(item:InvItem):
	var found = inv.find(item)
	return found
func addhealth(hp_regen,pp_regen):
	if player_team.index == 0:
		stats.hp += hp_regen
		stats.pp += pp_regen
		player_team.update_group(stats,player_team.index)
	else:
		StatLoader.player_group[player_team.index-1].stats.hp += hp_regen
		StatLoader.player_group[player_team.index-1].stats.pp += pp_regen
		player_team.update_group(StatLoader.player_group[player_team.index-1].stats,player_team.index)
	
	
func change_stat(hp_changed,pp_changed):
	stats.max_hp = hp_changed
	
	stats.max_pp = pp_changed
	player_team.update_group(stats,0)
	
func buy(price:float):
	stats.money -= price
	$RichTextLabel.text =  "$" + str(stats.money)
	
func change_weapon(weapon_arrow,weapon_speed):
	stats.weapons = weapon_arrow
	stats.weapon_speed = weapon_speed

func removehealth(hp_loss):
	var sfx = load("res://sounds/explosion.mp3")
	$AudioStreamPlayer2D.stream = sfx
	$AudioStreamPlayer2D.play()
	if player_team.index == 0:
		stats.hp -= hp_loss
		player_team.update_group(stats,player_team.index)
		$AnimatedSprite2D.show()
		$AnimatedSprite2D.play("explode")
		await get_tree().create_timer(0.5).timeout
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.hide()
		#self.queue_free()
		#$AnimatedSprite2D.play("default")
	else:
		StatLoader.player_group[player_team.index-1].stats.hp -= hp_loss
		player_team.update_group(StatLoader.player_group[player_team.index-1].stats,player_team.index)

func update_pos():
	if StatLoader.previous_position != Vector2.ZERO:
		position = StatLoader.previous_position
	#print(position)

class_name Player extends CharacterBody2D
var dashes : int = 4
var parry : float
const DOUBLETAP_DELAY = .30
var doubletap_time = DOUBLETAP_DELAY
var last_keycode = 0
var max_dashes = dashes
var direction : Vector2 = Vector2.ZERO
var cardinal_direction : Vector2 = Vector2.DOWN
var run: int = 1
var dashing:bool = false
var dash_cooldown : float
var dash_window :float
var grav :Vector2 
var grav_from_outside:Vector2 =Vector2(0,0)
var grav_affected : bool = false
var accumulate : float
signal compare_position(last_position:Vector2)
var signaled : bool = true
var grav_priority : int = 0
var dash_window_duration : float
@onready var animation_player : AnimationPlayer= $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine
#$"."
func _ready() -> void:
	
	compare_position.connect(compare_pos)
	state_machine.initialize(self)
	update_progress()
	parry = $"../../PlayerGroup".parry
	dash_window_duration = $"../../PlayerGroup".dash_window #0.1 #
	$StateMachine/walk. move_speed =  $"../../PlayerGroup".walk_speed# 250 #
	if $"../../PlayerGroup".dash_window == 0.25:
		$skateboard.show()
	else:
		$skateboard.hide()
	pass # Replace with function body.




func update_progress():
	if max_dashes > 0:
		$"../ProgressBar".value = dashes*100/max_dashes 
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#print(direction)
	if get_last_slide_collision() != null:
		#print(get_last_slide_collision().get_normal())
		if signaled:
			#var last_pos = position - velocity
			signaled= false
			compare_position.emit(get_last_slide_collision().get_normal(), -grav.normalized())#*delta)
			await get_tree().create_timer(0.05).timeout
		#print(get_last_slide_collision().get_collider())
	elif !grav_affected:
		
		
		grav_affected = true
		#await get_tree().create_timer(0.05).timeout
		accumulate = 0
		grav *= 0
	if grav_affected:
		
		accumulate += (delta)*30
		grav = grav_from_outside * accumulate
		#await get_tree().create_timer(1).timeout
		
		
	if dash_cooldown<= 0 and dashes < max_dashes:
		#dash_cooldown.stop()
		
		dashes +=1
		dash_cooldown = 1.5
		update_progress()
	doubletap_time -= delta
	parry -= delta
	dash_cooldown -= delta
	
	dash_window -= delta
	direction = Vector2(Input.get_axis("left","right"),Input.get_axis("up","down")).normalized()
	if parry >= 0.45 and parry<0.75:
		pass
	if dash_window > 0 and dashing:
		direction*=2.4
		#current_anim = animation_player.current_animation
		
		animation_player.play("dash")
	elif dash_window <= 0:
		sprite.modulate.a = 1
		direction = direction.normalized() 
		dashing =  false
		dash_window=0
	pass
	
func compare_pos(last_col_normal:Vector2,grav_dir:Vector2):
	var on_floor: bool=  false
	#print(last_col_normal)
	
	if (grav_dir.x > 0 and ceil(last_col_normal.x-0.05) == grav_dir.x) or (grav_dir.x < 0 and floor(last_col_normal.x+0.05) ==  grav_dir.x):
		on_floor = true
	elif(grav_dir.y > 0 and ceil(last_col_normal.y-0.05) == grav_dir.y) or  (grav_dir.y < 0 and floor(last_col_normal.y+0.05) ==  grav_dir.y):
		on_floor = true
		#up_direction
	
	if on_floor:
		grav_affected =false
	#if last_col_normal==grav_dir:
		#velocity -= grav
		accumulate = 0
		grav *= 0
		#print("buttass")
	#elif if abs(grav_dir.y) > 0 and ceil(last_col_normal.y)==grav_dir.y:
	else:
		await get_tree().create_timer(0.05).timeout
		grav_affected =true
		grav = grav_from_outside * accumulate
	signaled= true
	pass
	

		
func _input(event: InputEvent):
	var sfx = load("res://Assets/sounds/shot_sound.wav")
	var sfx2 = load("res://sounds/block.mp3")
	if Input.is_action_just_pressed("shoot") and parry <= 0:
		$AnimatedSprite2D.play("block")
		$AudioStreamPlayer.stream = sfx2
		$AudioStreamPlayer.play()
		parry = 0.75
	if Input.is_action_just_pressed("left")||Input.is_action_just_pressed("right")||Input.is_action_just_pressed("up")||Input.is_action_just_pressed("down") :
		
		if last_keycode == event.keycode and  doubletap_time >= 0 and doubletap_time < 0.2: 
			
			last_keycode = 0
			run = 2
			if dashes>0 and dash_window<=0:
				$AudioStreamPlayer.stream = sfx
				dash_window= (dash_window_duration)
				dash_cooldown=1.25
				dashes -= 1
				update_progress()
				dashing = true
				$AudioStreamPlayer.play()
		else:
			last_keycode = event.keycode
		
		doubletap_time = DOUBLETAP_DELAY

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
	
func SetDirection() -> bool:
	var new_dir : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:

		return false
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	if new_dir == cardinal_direction:
		return false
	cardinal_direction = new_dir
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func UpdateAnimation(state : String) -> void:
	animation_player.play(state + "_" + AnimDirect())
	pass
	
func AnimDirect() -> String:
	if cardinal_direction == Vector2.DOWN:
		$skateboard.rotation_degrees =90
		return "down"
	elif cardinal_direction == Vector2.UP:
		$skateboard.rotation_degrees =90
		return "up"
	else:
		$skateboard.rotation_degrees =0
		return "side"

func take_damage(damage,object):
	var sfxprry = load("res://sounds/prry.mp3")
	if dash_window <= 0 and $"../../PlayerGroup"!= null and (parry < 0.52 or parry>=0.75):
		#for i in $"../../PlayerGroup".players:
		#await get_tree().create_timer(0.02).timeout
		dash_window = 0.5
		
		$"../../PlayerGroup".players.pick_random().take_damage(damage*$"../../PlayerGroup".in_damage_multiplier)
		if get_tree()!= null:
			animation_player.play("dash")
			await get_tree().create_timer(animation_player.current_animation_length).timeout

			animation_player.play("dash")

			animation_player.stop()
	elif parry >= 0.45 and parry<0.75:
		parry= 0.15
		if object and get_tree()!=null:
			
			var tween = get_tree().create_tween().bind_node(object)
			tween.tween_property(object, "position",(object.position-position)*30, 0.2).set_delay(0.05)
		dash_window = 0.4
		$"../../EnemyGroup".enemies.pick_random().take_damage(damage*$"../../EnemyGroup".damage_multiplier)
		$AnimatedSprite2D.play("parry")	#await get_tree().create_timer(animation_player.current_animation_length-0.2).timeout
		$AudioStreamPlayer.stream = sfxprry
		$AudioStreamPlayer.play()	#modulate.a = 1
			
			#await get_tree().create_timer(animation_player.current_animation_length-0.2).timeout

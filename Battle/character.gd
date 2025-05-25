extends CharacterBody2D
@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var progress_bar = $ProgressBar
@onready var hp_label = $HP
@onready var focus = $Focus
@export var MAX_HP : float = 20
var weapon_speed : float = 1:
	set(value):
		weapon_speed = value
var weapons : int = 0:
	set(value):
		weapons = value
var start_battle = true
var MAX_PP : float = 0
var pp : float = 0:
	set(value):
		pp = value
		
var hp : float = 20:
	set(value):
		hp = value
		if start_battle == false:
			
			_update_progress_bar()
			_play_animation("hurt")
			

func _ready() -> void:
	start_battle = false
	await get_tree().create_timer(0.1).timeout
	
	_update_progress_bar()


func set_stats(stats):
	hp = stats.hp
	MAX_HP = stats.max_hp
	
	if stats is playerStat:
		
		weapons = stats.weapons
		pp = stats.pp
		MAX_PP = stats.max_pp
		weapon_speed = stats.weapon_speed
		$ProgressBarPP.value  = (pp/MAX_PP)*100
		$PP.text = "PP "+ str(int(pp)) +"/" +str(int(MAX_PP))
func _update_progress_bar():
	hp_label.text = "HP "+  str(int(hp)) +"/" +str(int(MAX_HP))
	progress_bar.value = (hp/MAX_HP)*100
	if MAX_PP > 0:
		$ProgressBarPP.value  = (pp/MAX_PP)*100
		$PP.text = "PP "+ str(int(pp)) +"/" +str(int(MAX_PP))

func _play_animation(anim: String):
	var current_frame = sprite.get_frame()
	var current_anim = animation_player.current_animation
	
	
	animation_player.play(anim)
	await get_tree().create_timer(animation_player.current_animation_length).timeout
	animation_player.play(current_anim)
	sprite.set_frame(current_frame)

func _focus():
	focus.show()

func _unfocus():
	focus.hide()

func take_damage(value):
	hp -= value

func _stop_animation():
	animation_player.stop()

func take_stamina(value):
	pp -= value

func addhealth(hp_regen,pp_regen):
	hp += hp_regen
	pp += pp_regen

func removehealth(hp_loss):
	var sfx = load("res://sounds/explosion.mp3")
	$"../../AudioStreamPlayer2D".stream = sfx
	$"../../AudioStreamPlayer2D".play()
	take_damage(hp_loss)
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("explode")
	await get_tree().create_timer(0.5).timeout
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.hide()

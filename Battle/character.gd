extends CharacterBody2D
@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var progress_bar = $ProgressBar
@onready var focus = $Focus
@export var MAX_HP : float = 20
var weapon : int = 0:
	set(value):
		weapon = value
var start_battle = true
var MAX_PP : float = 20
var pp : float = 20:
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
	hp = stats[0]
	MAX_HP = stats[0]

	weapon = stats[1]
	pp = stats[2]
	MAX_PP = stats[2]
	
	
func _update_progress_bar():
	
	progress_bar.value = (hp)

func _play_animation(anim: String):
	#var current_anim = animation_player.current_animation
	animation_player.play(anim)
#	animation_player.play(current_anim)

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
	if pp > MAX_PP:
		pp = MAX_PP

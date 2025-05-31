extends Area2D
@export var damage : int
var is_alive : bool = true
@export var release_time : float 
var time :float = 2.4
@export var go_around : bool = true
signal play_hit#$BasicEnemyAttack/Node
@onready var attk_target  = $"../../Player_base"
#@onready var anim_player = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(self,"rotation",18,8)
	play_hit.connect(hit_play)
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if time > 0:
	time -= delta
	#rotation_degrees += 3
	if time < release_time and time > 0:
		position += Vector2(4.5,0)
	if time<=0 and go_around:
		#self.queue_free()
		var tween = get_tree().create_tween().bind_node(self)
		tween.tween_property(self,"position",(position+ Vector2(-1500,0)),5)
		#await get_tree().create_timer(0.3).timeout
		go_around = false
	if time < -5:
		self.queue_free()
		
		
		
		
func hit_play():
	
	if is_alive:
		
		var tween = get_tree().create_tween().bind_node(self)#.set_trans(Tween.TRANS_ELASTIC)
		
		
		if attk_target.dash_window <= 0.01:
			attk_target.take_damage(damage)
			
			
		#tween.tween_callback(self.queue_free)

func _on_body_entered(body: Node2D) -> void:
	play_hit.emit()
	is_alive = false
	pass # Replace with function body.

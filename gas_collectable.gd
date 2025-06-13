extends StaticBody2D
var move_denominator
var negative
@export var item: InvItem
var player = null
var nega2 
var deno2
@onready var sprite = $Sprite2D
func _ready() -> void:
	sprite.texture = item.texture
	if item.name == "stinkyFly":
		negative = false
		move_denominator = 1
		deno2 = 1
		nega2 = false
func _on_interactable_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		if player.find_item(null).size() > 0:
			playercollect()
			await get_tree().create_timer(0.1).timeout
			self.queue_free()
func _process(delta: float) -> void:
	if item.name == "stinkyFly":
		var fluxxing = flux(2*delta,move_denominator,negative)
		
		var flux2 = flux(delta/0.75,deno2,nega2)
		negative = fluxxing[1]
		nega2 = flux2[1]
		move_denominator = fluxxing[0]
		deno2= flux2[0]
	#velocity = Vector2(10*(fluxxing),0)
		position += Vector2(5*(fluxxing)[0],(flux2)[0])
	#print(velocity)
	pass

	
	
	
func flux(value,move_denominator2,negative2):
	#if move_denominator > -1:
		
	if move_denominator2 <= -1:
		move_denominator2 = -1
		negative2 = true
	if move_denominator2 >= 1:
		move_denominator2 = 1
		negative2 = false
	if negative2:
		move_denominator2 += value
	else:
		move_denominator2 -= value
	
	return [move_denominator2,negative2]
func playercollect():
	player.collect_item(item)

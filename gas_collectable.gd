extends StaticBody2D

@export var item: InvItem
var player = null
@onready var sprite = $Sprite2D
func _ready() -> void:
	sprite.texture = item.texture
func _on_interactable_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		if player.find_item(null).size() > 0:
			playercollect()
			await get_tree().create_timer(0.1).timeout
			self.queue_free()
		
func playercollect():
	player.collect_item(item)

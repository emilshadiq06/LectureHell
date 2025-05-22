extends Area2D
@export var item : InvItem
#var team = preload("res://Game/Player/player_team.tscn").instantiate()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		#StatLoader.player_group.push_back(team.get_child(StatLoader.player_group.size()).duplicate())
		#print(StatLoader.player_group)
		await get_tree().create_timer(0.2).timeout
		body.collect_item(item)
		await get_tree().create_timer(0.2).timeout

extends Area2D

var team = preload("res://Game/Player/player_team.tscn").instantiate()

func _on_body_entered(body: Node2D) -> void:
	#if body is Player:
	pass

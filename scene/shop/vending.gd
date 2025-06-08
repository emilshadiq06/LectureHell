extends Area2D
class_name shop
@onready var stuff_list = $scroll/VBoxContainer
@export var shop_items:Array[InvItem]
@export var shop_prices:Array[float]
var player : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	stuff_list.get_child(0).name = shop_items[0].name
	stuff_list.get_child(0).text = shop_items[0].name +" "+ str(shop_prices[0])
	stuff_list.get_child(0).item_index = 0
	stuff_list.get_child(0).item_pos.connect(item_pressed)
	for i in range(shop_items.size()-1):
		var new_item = stuff_list.get_child(0).duplicate()
		new_item.name = shop_items[i+1].name
		new_item.text = shop_items[i+1].name + " " + str(shop_prices[i+1])
		new_item.item_index = i+1
		stuff_list.add_child(new_item)
		stuff_list.get_child(i+1).item_pos.connect(item_pressed)




func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		$buy.show()
		$buy.disabled = false
	pass # Replace with function body.

func item_pressed(item_index:int):
	print(item_index)
	if player.stats.money >= shop_prices[item_index]:
		if player.find_item(null).size() == 0:
				player.player_invUI.selected_items = 0 
				player.player_invUI._on_throw_pressed()
				#player.inv.throw(0,player.inv.items[0])
		player.collect_item(shop_items[item_index].duplicate())
		#player.stats.money -= shop_prices[item_index]

		player.buy(shop_prices[item_index])
		AudioPlayer.play_audio("res://sounds/moneysfx.mp3")
	else:
		AudioPlayer.play_audio("res://sounds/denied.mp3")

func _on_buy_pressed() -> void:
	stuff_list.show()
	for i in stuff_list.get_children():
		if i is Button:
			i.grab_focus()
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body == player:
		$buy.hide()
		for i in stuff_list.get_children():
			if i is Button:
				i.release_focus()
		$buy.disabled = true
		stuff_list.hide()
	

		body = null
	pass # Replace with function body.

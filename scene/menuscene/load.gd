extends CanvasLayer

@export_file("*.tscn") var next_scene_path: String


@export var scene_args: Array
@export var tips: Array[Dictionary] = [
	{"title": "Make sure to complete the mission", "text": "When you complete your mission you will earn coins."},
	{"title": "Play the game with full relax", "text": "Are you trying to speedrun this game? LOLOLOL"}
	
]

var parameters: Dictionary
var loaded := false


func _ready():
	var selected_tips := tips[randi() % tips.size()]
	%TipLabel.text = "Tip: %s" % selected_tips.title
	%TipText.text = selected_tips.text
	ResourceLoader.load_threaded_request(next_scene_path)
	$Control/Label/AnimationPlayer.play("new_animation")
	
func _process(_delta):
	if ResourceLoader.load_threaded_get_status(next_scene_path) == ResourceLoader.THREAD_LOAD_LOADED:
		set_process(false)
		await get_tree().create_timer(2).timeout
		loaded = true
		%Label.text = "wait pls"
		var new_scene: PackedScene = ResourceLoader.load_threaded_get(next_scene_path)
		var new_node = new_scene.instantiate()
		new_node.parameters = parameters
		var current_scene = get_tree().current_scene
		get_tree().get_root().add_child(new_node)
		get_tree().current_scene = new_node
		current_scene.queue_free()
		
		
func open_new_scene():
	if loaded:
		var new_scene: PackedScene = ResourceLoader.load_threaded_get(next_scene_path)
		var new_node = new_scene.instantiate()
		if "parameters" in new_node:
			new_node.parameters = parameters
		var last_scene = get_tree().current_scene
		get_tree().current_scene = new_node
		get_tree().get_root().add_child(new_node)
		last_scene.queue_free()
		

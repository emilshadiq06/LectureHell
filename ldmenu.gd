extends Control

var next_scene = "res://player.tscn"

func _ready():
	ResourceLoader.load_threaded_request(next_scene)
	
func _process(delta):
	var progress = []
	ResourceLoader.load_threaded_request(next_scene, progress)
	$ProgressBar.value = progress [0]*100
	$Label2.text = str(progress[0]*100)+"%"
	
	

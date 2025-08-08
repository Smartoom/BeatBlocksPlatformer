extends Area2D

@export var can_interact = false
func interact():
	#load new level
	print("load new level")
	load_new_level()
	pass

func load_new_level():
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int() + 1
	
	var next_level_path = "res://Scenes/Levels/level"+next_level_number+".tscn"
	get_tree().change_scene_to_file(next_level_path)
	

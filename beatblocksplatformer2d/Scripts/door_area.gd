extends Area2D

@export var can_interact = false
func interact():
	#load new level
	print("load new level")
	get_tree().get_first_node_in_group("Player").WalkInDoor(global_position)
	$Timer.start()
	pass

func load_new_level():
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int() + 1
	
	var next_level_path = "res://Scenes/Levels/level_"+str(next_level_number)+".tscn"
	get_tree().change_scene_to_file(next_level_path)
	

func _on_timer_timeout() -> void:
	load_new_level()

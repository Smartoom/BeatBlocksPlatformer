extends Node

@export var checkpoints:Array[Node2D]
var last_checkpoint :int = -1
@onready var restart_prompt := $CanvasLayer/RichTextLabel
#var should_prompt_restart = false

var player_node : Node2D
func _ready() -> void:
	player_node = get_tree().get_first_node_in_group("Player")

func _process(_delta: float) -> void:
	if player_node.is_dead:
		restart_prompt.visible = true
	
	if Input.is_action_just_pressed("Restart") && last_checkpoint!=-1:
		player_node.position = checkpoints.get(last_checkpoint).global_position
		restart_prompt.visible = false
		player_node.revive()
		
		#reset resettable objects
		var list_of_things_to_reset := get_tree().get_nodes_in_group("Resettable")
		for object_to_reset in list_of_things_to_reset:
			object_to_reset.reset_object()


func _on_restart_prompt_area_body_entered(body : Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	restart_prompt.visible = true

func set_new_check_point (new_check_point : Node2D):
	last_checkpoint = checkpoints.find(new_check_point)

func set_new_check_point_int (new_check_point:int):
	last_checkpoint = new_check_point

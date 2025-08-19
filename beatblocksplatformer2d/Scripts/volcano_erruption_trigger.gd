extends Area2D

@export var player_camera:Camera2D
@export var original_limit_left = 0
@export var original_limit_top = 0
@export var original_limit_right = 0
@export var original_limit_bottom = 0

@export var new_limit_left = 0
@export var new_limit_top = 0
@export var new_limit_right = 0
@export var new_limit_bottom = 0
@export var lava:Node


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	print("erruption trigger")
	player_camera.limit_left = new_limit_left
	player_camera.limit_right = new_limit_right
	player_camera.limit_top = new_limit_top
	player_camera.limit_bottom = new_limit_bottom
	lava.erupt()

func reset_object():
	player_camera.limit_left = original_limit_left
	player_camera.limit_right = original_limit_right
	player_camera.limit_top = original_limit_top
	player_camera.limit_bottom = original_limit_bottom

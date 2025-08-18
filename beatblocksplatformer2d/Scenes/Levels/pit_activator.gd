extends Area2D

@export var beat_start :Area2D
@export var beat_stop :Area2D
@export var parent_of_appearing_platforms : Node
var platforms_to_enable := []
var platforms_enabled = false

func _ready() -> void:
	for platform in parent_of_appearing_platforms.get_children(false):
		platforms_to_enable.append(platform)
	$DisablePlatformsStartTimer.start()
func _on_disable_platforms_start_timer_timeout() -> void:
	disable_platforms()

func _on_body_entered_pit(body: Node2D) -> void:
	if not body.is_in_group("Player") or platforms_enabled:
		return
	
	#print("player entered pit")
	$WaitbeforeEnablePlatformsTimer.start()
func _on_waitbefore_enable_platforms_timer_timeout() -> void:
	#print("playing is staying in the pit, showing platforms")
	platforms_enabled = true
	beat_start.set_deferred("monitoring", true)
	beat_stop.set_deferred("monitoring", true)
	
	enable_platforms()

func enable_platforms():
	for platform in platforms_to_enable:
		platform.show_platform()

func disable_platforms():
	for platform in platforms_to_enable:
		platform.hide_platform()

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player") or !platforms_enabled:
		return
	#print("player left pit")
	
	disable_platforms()
	beat_start.set_deferred("monitoring", false)
	beat_stop.set_deferred("monitoring", false)
	platforms_enabled = false

extends RigidBody2D

var original_position : Vector2

func _ready() -> void:
	original_position = global_position

func _on_timer_timeout() -> void:
	freeze = false
	$ShakeAnimationPlayer.stop()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	$ShakeAnimationPlayer.play("Shake")
	$Timer.start()

func reset_object():
	global_position = original_position
	linear_velocity = Vector2.ZERO
	freeze = true

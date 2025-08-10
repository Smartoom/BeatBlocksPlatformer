extends RigidBody2D


func _on_timer_timeout() -> void:
	freeze = false
	$ShakeAnimationPlayer.stop()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	$ShakeAnimationPlayer.play("Shake")
	$Timer.start()

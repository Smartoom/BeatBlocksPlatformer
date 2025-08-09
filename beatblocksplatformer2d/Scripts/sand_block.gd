extends RigidBody2D


func _on_timer_timeout() -> void:
	freeze = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	print("laa")
	$Timer.start()

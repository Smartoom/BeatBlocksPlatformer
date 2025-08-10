extends StaticBody2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	$Timer.start()
	$AnimatedSprite2D.play("Break")


func _on_timer_timeout() -> void:
	var particles := $CPUParticles2D
	particles.emitting = true
	particles.reparent(get_tree().root)
	queue_free()

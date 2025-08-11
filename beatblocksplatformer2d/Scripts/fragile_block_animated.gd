extends AnimatableBody2D


var original_position : Vector2

func _ready() -> void:
	original_position = global_position

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	$Timer.start()
	$AnimatedSprite2D.play("Break")


func _on_timer_timeout() -> void:
	$CPUParticles2D.emitting = true
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.visible = false
	$Area2D.monitoring = false
	#disable

func reset_object():
	$CPUParticles2D.emitting = false
	global_position = original_position
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.play("Idle")
	$Area2D.monitoring = true
	$Timer.stop()

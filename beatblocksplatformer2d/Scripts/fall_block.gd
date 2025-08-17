extends RigidBody2D

var original_position : Vector2
var has_fallen = false

func _ready() -> void:
	original_position = global_position

func _on_timer_timeout() -> void:
	freeze = false
	has_fallen = true
	$ShakeAnimationPlayer.stop()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player") or has_fallen:
		return
	
	$ShakeAnimationPlayer.play("Shake")
	$Timer.start()

func reset_object():
	global_position = original_position
	linear_velocity = Vector2.ZERO
	has_fallen = false
	freeze = true

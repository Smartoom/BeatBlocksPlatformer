extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
		
	get_parent().disable_sound()

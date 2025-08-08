extends Node

var fell = false
func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	if $AnimationPlayer.current_animation == "FallDown" or fell:
		return
	$AnimationPlayer.play("FallDown")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "FallDown":
		$DoorArea.can_interact = true
		fell = true

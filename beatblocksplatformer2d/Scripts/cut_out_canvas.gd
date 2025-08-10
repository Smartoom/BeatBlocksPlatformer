extends CanvasLayer

func start_fade_out(position_on_screen:Vector2):
	$AnimationPlayer.play("FadeOut")
	$ColorRect.material.set_shader_parameter("position_on_screen",position_on_screen)

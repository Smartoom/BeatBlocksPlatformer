extends CanvasLayer

func start_fade_out(position_on_screen:Vector2):
	$AnimationPlayer.play("FadeOut")
	visible = true
	$ColorRect.material.set_shader_parameter("position_on_screen",position_on_screen)

func start_fade_in(position_on_screen:Vector2):
	$AnimationPlayer.play("FadeIn")
	visible = true
	$ColorRect.material.set_shader_parameter("position_on_screen",position_on_screen)

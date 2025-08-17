extends AnimatableBody2D


@export var animation_dip_amplitude := 10.0
@export var upward_force = 10.0
@onready var dippingTimer := $dippingTimer
@onready var pushTimer := $pushingTimer
var original_pos : Vector2
var dipping = false
var pushed = false

func _ready() -> void:
	original_pos = position

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	start_dip()

func start_dip():
	dipping = true
	pushed = false
	dippingTimer.start()

func _physics_process(delta: float) -> void:
	if dipping:
		var progress = dippingTimer.wait_time - dippingTimer.time_left
		var sinValue = -sin(PI * 2.0 * (progress / dippingTimer.wait_time))
		if (sinValue > 0.4 and pushTimer.is_stopped() and !pushed):
			pushTimer.start()
			pushed = true
			constant_linear_velocity = Vector2.UP * upward_force
		position = original_pos + Vector2.UP * sinValue * animation_dip_amplitude

func _on_timer_timeout() -> void:
	position = original_pos
	dipping = false


func _on_pushing_timer_timeout() -> void:
	constant_linear_velocity = Vector2.ZERO

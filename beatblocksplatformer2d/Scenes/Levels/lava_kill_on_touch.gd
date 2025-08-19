extends Area2D

var moving = false
@export var speed := 20.0
var original_position:Vector2

func _ready() -> void:
	original_position = global_position

func _physics_process(delta: float) -> void:
	if moving:
		global_position += speed * delta * Vector2.UP

func erupt():
	moving = true
func stop_erruption():
	moving = false

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	
	body.die()
	stop_erruption()

func reset_object():
	stop_erruption()
	global_position = original_position

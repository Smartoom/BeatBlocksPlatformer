extends Node2D

@export var rotationSpeed := 2.5
@export var distance := 24.0
@export var fireballs:Array[Node2D]
var rotation_progress : float

func _ready() -> void:
	rotation_progress = randf() * 2 * PI
	
	for i in range(fireballs.size()):
		fireballs[i].position = Vector2(distance * i, 0)

func _process(delta: float) -> void:
	rotation_progress += delta * rotationSpeed
	
	for i in range(fireballs.size()):
		var newPos = Vector2(cos(rotation_progress), sin(rotation_progress))
		var distance = (distance * i)
		fireballs[i].position = newPos * distance

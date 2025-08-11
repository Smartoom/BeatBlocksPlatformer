extends Node2D

@export var blocks:Array[Node2D]
@export var speed = .5
@export var distance = 144.0
@export var lines:Array[Line2D]
#@onready var first_line := $Line2D
#
#func _ready() -> void:
	#for i in range(blocks.size()-1):
		#lines.append(first_line.duplicate())

var progress = 0.0
func _physics_process(delta: float) -> void:
	progress += delta * speed
	
	for i in range(blocks.size()):
		var value = (2 * PI * i) / blocks.size()
		var total = progress+value
		var newPos = Vector2(cos(total), sin(total)) * distance
		lines[i].points[1]=newPos
		
		if blocks[i]==null:
			continue
		blocks[i].position = newPos

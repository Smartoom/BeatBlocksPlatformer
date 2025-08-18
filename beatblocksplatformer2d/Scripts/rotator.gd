extends Node2D

@export var blocks:Array[Node2D]
@export var speed = .5
@export var lines:Array[Line2D]
@export var distance = 144.0:
	set(new_dist):
		distance = new_dist
		for i in range(blocks.size()):
			var value = (2 * PI * i) / blocks.size()
			var total = value
			var newPos = Vector2(cos(total), sin(total)) * distance
			lines[i].points[1]=newPos
			
			if blocks[i]==null:
				continue
			blocks[i].position = newPos

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

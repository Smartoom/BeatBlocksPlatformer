extends Node

signal beat
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	beat.emit()

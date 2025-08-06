extends Node

signal beat

@onready var audioPlayer := $AudioStreamPlayer2D

func _on_timer_timeout() -> void:
	beat.emit()
	audioPlayer.play()

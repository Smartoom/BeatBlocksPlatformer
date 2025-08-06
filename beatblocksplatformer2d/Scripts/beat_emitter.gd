extends Node

signal beat

@onready var bopPlayer := $BopAudio
@onready var bapPlayer := $BapAudio

var bop_or_bap :bool = false 

func _on_timer_timeout() -> void:
	beat.emit()
	if bop_or_bap:
		bopPlayer.play()
	else:
		bapPlayer.play()
	bop_or_bap = not bop_or_bap

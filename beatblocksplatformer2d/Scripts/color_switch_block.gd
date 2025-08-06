extends StaticBody2D

@onready var visual := $ColorRect
@onready var collisionShape := $CollisionShape2D

@export var darkenedColorDarkness :float = 0.5
var darkColor : Color
var normalColor :Color

@export var active : bool

func _ready() -> void:
	normalColor = visual.color
	darkColor = normalColor.darkened(darkenedColorDarkness)
	
	disable()
	get_tree().root.get_child(0).get_node("BeatEmitter").connect("beat",on_beat_change)

func on_beat_change():
	active = not active
	if active:
		enable()
	else:
		disable()

func enable():
	visual.color =  normalColor
	collisionShape.disabled = false
func disable():
	visual.color = darkColor
	collisionShape.disabled = true

func _process(delta: float) -> void:
	pass

extends StaticBody2D

@onready var actived_sprite := $ActivatedSprite
@onready var deactivated_sprite := $DeactivatedSprite
@onready var collisionShape := $CollisionShape2D

@export var active : bool

func _ready() -> void:
	disable()
	get_tree().root.get_child(0).get_node("BeatEmitter").connect("beat",on_beat_change)

func on_beat_change():
	active = not active
	if active:
		enable()
	else:
		disable()

func enable():
	actived_sprite.visible = true
	deactivated_sprite.visible = false
	collisionShape.disabled = false

func disable():
	actived_sprite.visible = false
	deactivated_sprite.visible = true
	collisionShape.disabled = true

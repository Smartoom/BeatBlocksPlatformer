extends StaticBody2D

@onready var actived_sprite := $ActivatedSprite
@onready var deactivated_sprite := $DeactivatedSprite
@onready var collisionShape := $CollisionShape2D

@export var active : bool
#var platform_hiddden = false
var original_position :Vector2
var hiding_position := Vector2(0,8000)

func _ready() -> void:
	disable()
	original_position = position
	get_tree().root.get_child(0).get_node("BeatEmitter").connect("beat",on_beat_change)

func on_beat_change():
	#if platform_hiddden:
		#return
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

func hide_platform():
	collisionShape.set_deferred("disabled", true)
	position = hiding_position
	visible = false
func show_platform():
	collisionShape.set_deferred("disabled", false)
	position = original_position
	visible = true

extends CharacterBody2D


const SPEED = 120.0
const GROUNDED_STOP_TIME = 25
const AIR_STOP_TIME = 6.25
const JUMP_VELOCITY = -250.0
const JUMP_BUFFER = 0.3
const HEIGHT = 26
var time_since_jump_pressed = 999.0
const jump_gravity = Vector2.DOWN * 450.0
const normal_gravity = Vector2.DOWN * 650.0
@onready var animated_sprite = $FlipPivot/AnimatedSprite2D
@onready var jump_particles = $JumpParticles
@onready var land_particles = $LandParticles

@onready var flip_pivot = $FlipPivot

var walking_inside_door = false
var grounded = false

func _ready() -> void:
	get_tree().get_first_node_in_group("CutOutCanvasLayer").start_fade_in(get_player_position_for_shader())

func handleGravity(delta: float):
	if not grounded:
		if (Input.is_action_pressed("Up") && velocity.y<=0):
			velocity += jump_gravity * delta
		else :
			velocity += normal_gravity * delta
	
func _physics_process(delta: float) -> void:
	if walking_inside_door:
		velocity = Vector2.ZERO
		return
	
	if not grounded and is_on_floor():
		land_particles.emitting = true
	
	grounded = is_on_floor()
	handleGravity(delta)
	
	time_since_jump_pressed+=delta
	if Input.is_action_just_pressed("Up"):
		time_since_jump_pressed = 0
	
	if time_since_jump_pressed < JUMP_BUFFER and is_on_floor():
		jump_particles.emitting = true
		time_since_jump_pressed = 999.0
		velocity.y = JUMP_VELOCITY
	
	
	var direction := Input.get_axis("Left", "Right")
	
	flip_character(direction)
	
	if direction:
		velocity.x = direction * SPEED
	else:
		if grounded:
			velocity.x = move_toward(velocity.x, 0, GROUNDED_STOP_TIME)
		else:
			velocity.x = move_toward(velocity.x, 0, AIR_STOP_TIME)
	
	
	move_and_slide()

func _process(delta: float) -> void:
	
	handle_animation()

func handle_animation():
	if walking_inside_door:
		animated_sprite.play("Walking In")
		return
	
	if grounded:
		if abs(velocity.x) == SPEED:
			animated_sprite.play("Walking")
		else:
			animated_sprite.play("Idle")
	else:
		animated_sprite.play("Jump")


func flip_character (direction):
	if (direction > 0 and flip_pivot.scale.x == -1):
		flip_pivot.scale.x = 1
	elif (direction < 0 and not flip_pivot.scale.x == -1):
		flip_pivot.scale.x = -1

func WalkInDoor(position:Vector2):
	walking_inside_door = true
	global_position = position + Vector2.UP * HEIGHT / 2
	get_tree().get_first_node_in_group("CutOutCanvasLayer").start_fade_out(get_player_position_for_shader())

func get_player_position_for_shader():
	var pos_in_screen = get_global_transform_with_canvas().origin
	pos_in_screen.x = clamp(pos_in_screen.x, 0, get_viewport_rect().size.x)/ get_viewport_rect().size.x
	pos_in_screen.y = clamp(pos_in_screen.y, 0, get_viewport_rect().size.y)/ get_viewport_rect().size.y
	return pos_in_screen

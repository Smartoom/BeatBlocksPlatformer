extends CharacterBody2D


const SPEED = 120.0
const GROUNDED_STOP_TIME = 25
const AIR_STOP_TIME = 6.25
const JUMP_VELOCITY = -250.0
const JUMP_BUFFER = 0.3
var time_since_jump_pressed = 999.0
const jump_gravity = Vector2.DOWN * 450.0
const normal_gravity = Vector2.DOWN * 650.0
@onready var sprite = $FlipPivot/Sprite2D
@onready var jump_particles = $JumpParticles
@onready var land_particles = $LandParticles

@onready var flip_pivot = $FlipPivot

var grounded = false

func handleGravity(delta: float):
	if not grounded:
		if (Input.is_action_pressed("Up") && velocity.y<=0):
			velocity += jump_gravity * delta
		else :
			velocity += normal_gravity * delta
	
func _physics_process(delta: float) -> void:
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

func flip_character (direction):
	if (direction > 0 and sprite.flip_h):
		sprite.flip_h = false
		flip_pivot.scale.x = 1
	elif (direction < 0 and not sprite.flip_h):
		sprite.flip_h = true
		flip_pivot.scale.x = -1

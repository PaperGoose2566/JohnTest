extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -800.0
const GRAV_MULT_MAX = 4.0
var grav_mult := 1.0

var is_jumping := false
var can_double_jump := true



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if is_jumping and velocity.y > 0:
			grav_mult = GRAV_MULT_MAX
		else:
			grav_mult = 1.0
		velocity += get_gravity() * delta * grav_mult
	else:
		grav_mult = 1.0
		is_jumping = false
		can_double_jump = true

	var a = float(!is_jumping) * 1.0

	print(a)
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or can_double_jump):
		velocity.y = jump_velocity
		is_jumping = true
		if not is_on_floor() and can_double_jump:
			can_double_jump = false
		
	if Input.is_action_just_pressed("ui_down") and is_jumping:
		velocity.y = 1500.0
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

extends CharacterBody2D


const MAX_SPEED = 200.0
const ACCELERATION = 20
const JUMP_VELOCITY = -300.0
const GROUND_FRICTION = 10
const AIR_FRICTION = 5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.x -= delta * AIR_FRICTION * velocity.x
		velocity.y += gravity * delta
	else:
		velocity.x -= delta * GROUND_FRICTION * velocity.x

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x += (MAX_SPEED - abs(velocity.x)) * (direction * ACCELERATION * delta)

	move_and_slide()

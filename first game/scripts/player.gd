extends CharacterBody2D

class_name is_falling

var isRolling = false
var isAttacking = false
var current_animation = ""
var animation_completed = false

const SPEED = 200.0
const JUMP_VELOCITY = -345.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite = $AnimatedSprite2D

func _ready():
	sprite.play("Idle")
	sprite.connect("animation_finished", self, "_on_animation_finished")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Flip character
	sprite.flip_h = direction < 0

	# Manage animation states
	if is_on_floor():
		if Input.is_action_just_pressed("roll"):
			isRolling = true
			isAttacking = false
		elif Input.is_action_just_pressed("Attack 1") or Input.is_action_just_pressed("Attack 2") or Input.is_action_just_pressed("Attack 3"):
			isAttacking = true
			isRolling = false
		elif direction == 0:
			isRolling = false
			isAttacking = false
		else:
			isRolling = false
			isAttacking = false

		if isRolling:
			set_animation("roll")
		elif isAttacking:
			set_animation("Attack")
		elif direction == 0:
			set_animation("Idle")
		else:
			set_animation("Run")
	else:
		if velocity.y > 0:
			set_animation("Falling")
		else:
			set_animation("Jump")

	# Apply movement
	if direction:
		velocity.x = direction * SPEED    
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func set_animation(anim_name: String):
	if current_animation != anim_name and not is_animation_playing():
		print("Setting animation to: ", anim_name)
		sprite.play(anim_name)
		current_animation = anim_name
		animation_completed = false

func _on_animation_finished(anim_name: String):
	animation_completed = true

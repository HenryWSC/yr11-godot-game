extends CharacterBody2D

class_name is_falling

var isRolling = false
var isAttacking = false

const SPEED = 200.0
const JUMP_VELOCITY = -345.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite = $AnimatedSprite2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	

	# Get the input direction and handle the movement/deceleration.
	# get direction of plauer (-1 left 0 unchanged 1 right
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#flip character
	if direction >= 0:
		sprite.flip_h = false
	elif direction <= 0:
		sprite.flip_h = true
	
	if Input.is_action_just_pressed("roll"):
		isRolling = true
		
	#changing animations
	if is_on_floor():
		if direction == 0:
			pass
		if isRolling == true:
			sprite.play("roll")
			
		elif direction == 0:
			sprite.play("Idle")
			isRolling == false
		else:
			sprite.play("Run") 
		isRolling == false
	else:
		sprite.play("Jump")
		isRolling == false
	
	if not is_on_floor() and velocity.y > 0:
		sprite.play("Falling")
		isRolling == false
	
	
	
	#Attacks
	if is_on_floor():
		if Input.is_action_just_pressed("Attack 1"):
			sprite.play("Attack 1")
			isRolling == false
			
		if Input.is_action_just_pressed("Attack 2"):
			sprite.play("Attack 2")
			isRolling == false
			
		if Input.is_action_just_pressed("Attack 3"):
			sprite.play("Attack 3")
			isRolling == false
	
	#apply movement
	if direction:
		velocity.x = direction * SPEED    
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

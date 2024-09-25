extends CharacterBody2D

#lets him play animations
@onready var sprite = $AnimatedSprite2D

@export var speed : float = 100.0
@export var change_direction_interval : float = 1
@export var move_duration : float = 1.0

var direction : int = 1
var time_since_last_change : float = 0.0
var time_moving : float = 0.0



var dead = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	choose_random_direction()
	add_to_group("Player")
	add_to_group("Skellybones")



func _process(delta: float) -> void:
	time_since_last_change += delta
	time_moving += delta
	if $AnimationPlayer.current_animation == "attack":
		return
	
	if direction >= 0:
		sprite.flip_h = false
	elif direction <= 0:
		sprite.flip_h = true

	if time_since_last_change >= change_direction_interval:
		choose_random_direction()
		time_since_last_change = 0.0
		time_moving = 0.0


	if time_moving < move_duration:
		velocity = Vector2(direction * speed, 0)  # Only move horizontally
	else:
		velocity = Vector2.ZERO

	# Update the position
	move_and_slide()

func choose_random_direction() -> void:
	# Random direction
	direction = randi_range(-1, 1)
	if direction == 0:  
		direction = 1
		
#he will die if player touches him

		
		



func _on_hitbox_body_entered(body):
	if body.is_in_group("Playerz"):
		sprite.play("die")
		speed = 0
		dead = true



func _on_animated_sprite_2d_animation_finished():
	if dead == true:
		queue_free()

func hit():
	$AttackDetector.monitoring = true

func end_of_hit():
	$AttackDetector.monitoring = false
	

func _on_PlayerDetector_body_entered(body):
	pass

func _on_AttackDetector_body_entered(body):
	get_tree().reload_current_scene()


func _on_player_detector_body_entered(body):
	$AnimationPlayer.play("attack")

extends CharacterBody2D

@export var speed: float = 200.0
@onready var timer: Timer = $Timer

var direction: Vector2 = Vector2.ZERO
var vector: Vector2 = Vector2.ZERO

func _ready():
	# Start the timer
	timer.start()
	# Set initial random direction
	_set_random_direction()

func _set_random_direction():
	# Generate a random direction
	var angle = randf_range(0, 2 * PI)
	direction = Vector2(cos(angle), sin(angle)).normalized()

func _on_Timer_timeout():
	# Change direction when timer times out
	_set_random_direction()

func _physics_process(delta: float) -> void:
	# Update velocity based on direction
	velocity = direction * speed

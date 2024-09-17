extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D

const speed = 30
var dir: Vector2

var is_skellybones_chase: bool
	
func _ready():
	is_skellybones_chase = false
	add_to_group("Player")

func _on_timer_timeout():
	$timer.wait_time = choose([1.0, 2.0, 3.0])
	if !is_skellybones_chase:
		dir = choose ([Vector2.RIGHT, Vector2.LEFT])
		print(dir)

func choose(array):
	array.shuffle()
	
func _on_hitbox_body_exited(body):
	if body.is_in_group("Player"):
		sprite.play("die")
	
	
	

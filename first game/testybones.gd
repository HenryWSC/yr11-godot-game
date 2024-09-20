extends CharacterBody2D

@export var attack_range: float = 100.0
@export var attack_cooldown: float = 1.0
var is_attacking: bool = false
var player: Node = null

func _ready() -> void:
	player = get_node("Path/To/player")  # Adjust the path to your player node

func _process(delta: float) -> void:
	if not is_attacking and is_player_in_range():
		attack_player()


func attack_player() -> void:
	is_attacking = true
	$AnimationPlayer.play("attack")  # Play attack animation
	player.take_damage(10)  # Adjust damage value as needed
	
	await get_tree().create_timer(attack_cooldown).timeout  # Wait for cooldown
	is_attacking = false

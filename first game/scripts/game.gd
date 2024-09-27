extends Node2D

@onready var pause_menu = $"Pause menu"
var paused = false

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
		
func _on_area_2d_body_entered(body):
	if body.name == "player":
		get_tree().reload_current_scene()
		

		

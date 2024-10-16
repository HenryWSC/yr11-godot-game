extends Node2D

func _on_area_2d_body_entered(body):
	if body.name == "player":
		get_tree().reload_current_scene()
		

func _on_hitbox_body_entered(body):
	if body.name == "player":
		get_tree().reload_current_scene()



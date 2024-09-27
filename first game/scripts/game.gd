extends Node2D

func _on_area_2d_body_entered(body):
	if body.name == "player":
		get_tree().reload_current_scene()
<<<<<<< HEAD
		


=======
>>>>>>> parent of a2dda32 (Merge branch 'henry' of https://github.com/HenryWSC/yr11-godot-game into henry)

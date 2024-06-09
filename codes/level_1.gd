extends Node2D

func _input(event): 
	if event.is_action("return_to_main_menu"):
		get_tree().change_scene_to_file("res://szenen/main_menu.tscn")

	elif event.is_action("restart"):
		get_tree().change_scene_to_file("res://szenen/level_1.tscn")


extends Node2D

func _on_ready():
	$Restart.grab_focus()

func _on_resart_pressed():
	get_tree().change_scene_to_file("res://szenen/level_1.tscn")

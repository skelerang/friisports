extends Control

func _input(event):
	if visible and event is InputEventKey and event.pressed:
		get_tree().change_scene("res://scenes/mainmenu.tscn")

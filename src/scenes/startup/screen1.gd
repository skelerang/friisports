extends Control


func _process(_delta):
	if visible:
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_start"):
			#warning-ignore:return_value_discarded
			get_tree().change_scene("res://scenes/mainmenu.tscn")


#func _input(event):
#	if visible and event is InputEventKey and event.pressed:
#		get_tree().change_scene("res://scenes/mainmenu.tscn")

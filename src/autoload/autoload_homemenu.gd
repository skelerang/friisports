extends Node

var menures = preload("res://autoload/homemenu/homemenu.tscn")
var nohomeres = preload("res://autoload/homemenu/nohome.tscn")

var menu
var nohome

func _process(_delta):
	if Input.is_action_just_pressed("ui_home"):
		if get_tree().get_root().get_node("main").get_node_or_null("nohome"):
			if not is_instance_valid(nohome):
				nohome = nohomeres.instance()
				get_tree().get_root().get_node("main").add_child(nohome)
		else:
			if not is_instance_valid(menu):
				menu = menures.instance()
				get_tree().get_root().get_node("main").add_child(menu)
				print("homed")
			else:
				menu._on_but_close_pressed()
				print("unhomed")

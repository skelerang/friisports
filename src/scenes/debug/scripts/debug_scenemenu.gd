# -------------------------------------- #
# --- Jyl's godot quick scenemenu v0 --- #
# -------------------------------------- #

# --- A menu to load any scene from a directory
# --- Usage: simply attach this to the main node in an empty scene

extends Node

var path = "res://scenes/"

var selected_scene = ""
var vbox_margin = 16
var vbox

func _ready():
	vbox = VBoxContainer.new()
	add_child(vbox)
	
	vbox.anchor_right = 1
	vbox.anchor_bottom = 1
	vbox.margin_left = vbox_margin
	vbox.margin_right = -vbox_margin
	vbox.margin_top = vbox_margin
	vbox.margin_bottom = -vbox_margin
	
	var title = Label.new()
	vbox.add_child(title)
	title.text = "debug scenemenu - doubleclick a scene to load it.\n" + path + "\n"
	
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.get_extension() == "tscn": 
				var button = LinkButton.new()
				button.text = file_name
				vbox.add_child(button)
				button.connect("pressed", self, "select_scene", [path + file_name])
				button.connect("gui_input", self, "on_input")
			file_name = dir.get_next()
	else:
		title.text = "can't open directory!! \n" + path
	
func on_input(_ev):
	pass
func select_scene(scene):
	selected_scene = scene
	change_scene()
func change_scene():
	#warning-ignore:return_value_discarded
	get_tree().change_scene(selected_scene)

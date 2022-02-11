extends Control

onready var menu = $menu
onready var menustart = $menu/start
onready var menumain = $menu/main

enum {
	ST_WAIT,
	ST_START,
	ST_MAINMENU,
	ST_CAT1MENU,
	ST_CAT2MENU
}

var state
var init_time

func _ready():
	state = ST_WAIT
	init_time = OS.get_ticks_msec()
	clear_all()
	
func _process(delta):
	match state:
		ST_WAIT:
			if OS.get_ticks_msec() - init_time > 500:
				state = ST_START
		ST_START:
			if !menustart.visible:
				clear_all()
				menustart.set_process(true)
				menustart.show()
			if Input.is_action_just_pressed("ui_accept"):
				state = ST_MAINMENU
		ST_MAINMENU:
			if !menumain.visible:
				clear_all()
				menumain.set_process(true)
				menumain.show()
			if Input.is_action_just_pressed("ui_cancel"):
				state = ST_START
		ST_CAT1MENU:
			pass
		ST_CAT2MENU:
			pass


func clear_all():
	for child in menu.get_children():
		child.set_process(false)
		child.hide()


func _on_air_sports_pressed():
	get_tree().change_scene("res://scenes/airscene_glide.tscn")
func _on_racquet_pressed():
	get_tree().change_scene("res://scenes/raqscene_badminton.tscn")
func _on_debug_pressed():
	get_tree().change_scene("res://scenes/debug_scenemenu.tscn")

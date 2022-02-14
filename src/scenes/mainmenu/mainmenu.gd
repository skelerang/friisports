extends Control

onready var menu = $menu
onready var menustart = $menu/start
onready var menumain = $menu/main

onready var overlay_black = $overlay_black

enum {
	ST_WAIT,
	ST_START,
	ST_MAINMENU,
	ST_CAT1MENU,
	ST_CAT2MENU,
	ST_SETTINGS
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
			Globals.cursor = false
			if OS.get_ticks_msec() - init_time > 500:
				state = ST_START
		ST_START:
			Globals.cursor = false
			if !menustart.visible:
				clear_all()
				menustart.set_process(true)
				menustart.show()
			if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_start"):
				state = ST_MAINMENU
		ST_MAINMENU:
			Globals.cursor = true
			if !menumain.visible:
				clear_all()
				menumain.set_process(true)
				menumain.show()
			if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("ui_start"):
				state = ST_START
		ST_CAT1MENU:
			pass
		ST_CAT2MENU:
			pass
		ST_SETTINGS:
			overlay_black.modulate.a += delta * 5
			if overlay_black.modulate.a > 1:
				get_tree().change_scene("res://scenes/mainmenu_settings.tscn")


func clear_all():
	for child in menu.get_children():
		child.set_process(false)
		child.hide()


func _on_air_sports_pressed():
	#warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/airscene_glide.tscn")
func _on_racquet_pressed():
	#warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/raqscene_badminton.tscn")
func _on_debug_pressed():
	#warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/debug_scenemenu.tscn")
func _on_settings_pressed():
	state = ST_SETTINGS
	overlay_black.show()
	overlay_black.modulate.a = 0

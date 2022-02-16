extends Control

onready var overlay_black = $overlay_black
onready var overlay_white = $overlay_white
onready var box_top = $menu/top
onready var box_mid = $menu/mid
onready var box_bot = $menu/bottom

# --- Top --- #
onready var tab1 = box_top.get_node("tab1")
onready var tab2 = box_top.get_node("tab2")
onready var tab3 = box_top.get_node("tab3")
onready var tablabel1 = tab1.get_node("Label")
onready var tablabel2 = tab2.get_node("Label")
onready var tablabel3 = tab3.get_node("Label")

const TAB_ALPHA1 = 1
const TAB_ALPHA2 = .5
const TAB_ALPHA3 = .25

const TAB_COLOR1 = Color(1,1,1,1)
const TAB_COLOR2 = Color(.5,.5,.5,1)
const TAB_COLOR3 = Color(.25,.25,.25,1)

const TAB_MARGIN1 = 0
const TAB_MARGIN2 = 16
const TAB_MARGIN3 = 32
const TAB_MARGIN4 = 64

# --- Mid --- #
onready var menu_settings = box_mid.get_node("menu_settings")
onready var menu_controls = box_mid.get_node("menu_controls")
onready var menu_controls_bind = box_mid.get_node("menu_controls_bind")
onready var menu_audio = box_mid.get_node("menu_audio")

var box_top_height = .16
var box_bottom_height = .2
enum {
	VIS_ST_IDLE
	VIS_ST_EXIT
}
enum {
	ST_MENU,
	ST_MENU_CONTROLS,
	ST_MENU_CONTROLS_BIND,
	ST_MENU_AUDIO
}

# --- Misc --- #
var state = ST_MENU
var visibility = 0
var vis_state = VIS_ST_IDLE
var tabstate = 1

func _ready():
	overlay_black.modulate.a = 1
	box_mid.modulate.a = 0
	
	box_top.anchor_top = -box_top_height
	box_top.anchor_bottom = 0
	box_bot.anchor_top = 1
	box_bot.anchor_bottom = 1 + box_bottom_height

func _process(delta):
	match state:
		ST_MENU:
			Globals.cursor = true
			if !menu_settings.visible:
				clear_all()
				menu_settings.set_process(true)
				menu_settings.show()
		ST_MENU_CONTROLS:
			if !menu_controls.visible:
				clear_all()
				menu_controls.set_process(true)
				menu_controls.show()
		ST_MENU_CONTROLS_BIND:
			if !menu_controls_bind.visible:
				clear_all()
				menu_controls_bind.set_process(true)
				menu_controls_bind.show()
		ST_MENU_AUDIO:
			if !menu_audio.visible:
				clear_all()
				menu_audio.set_process(true)
				menu_audio.show()
	
	match vis_state:
		VIS_ST_IDLE:
			visibility = clamp(visibility + delta * 5, -1, 1)
			
		VIS_ST_EXIT:
			visibility -= delta * 5
			overlay_black.modulate.a = -visibility + 1
			if visibility < 0:
				#warning-ignore:return_value_discarded
				get_tree().change_scene("res://scenes/mainmenu.tscn")
			
	overlay_black.modulate.a = -visibility + 1
	box_mid.modulate.a = visibility
	
	box_top.anchor_top = -box_top_height + (0 + box_top_height) * visibility
	box_top.anchor_bottom = 0 + (box_top_height - 0) * visibility
	box_bot.anchor_top = 1 + (1 - box_bottom_height - 1) * visibility
	box_bot.anchor_bottom = 1 + box_bottom_height + (1 - (1 + box_bottom_height)) * visibility
	
	var tabcolor1: Color
	var tabcolor2: Color
	var tabcolor3: Color
	var tabmargin1
	var tabmargin2
	var tabmargin3
	
	match tabstate:
		1:
			tab1.show()
			tab2.hide()
			tab3.hide()
			tabcolor1 = TAB_COLOR1
			tabcolor2 = TAB_COLOR1
			tabcolor3 = TAB_COLOR1
			tabmargin1 = TAB_MARGIN1
			tabmargin2 = TAB_MARGIN4
			tabmargin3 = TAB_MARGIN4
			tablabel1.show()
			tablabel2.show()
			tablabel3.show()
		2:
			tab1.show()
			tab2.show()
			tab3.hide()
			tabcolor1 = TAB_COLOR2
			tabcolor2 = TAB_COLOR1
			tabcolor3 = TAB_COLOR1
			tabmargin1 = TAB_MARGIN2
			tabmargin2 = TAB_MARGIN1
			tabmargin3 = TAB_MARGIN4
			tablabel1.hide()
			tablabel2.show()
			tablabel3.show()
		3:
			tab1.show()
			tab2.show()
			tab3.show()
			tabcolor1 = TAB_COLOR3
			tabcolor2 = TAB_COLOR2
			tabcolor3 = TAB_COLOR1
			tabmargin1 = TAB_MARGIN3
			tabmargin2 = TAB_MARGIN2
			tabmargin3 = TAB_MARGIN1
			tablabel1.hide()
			tablabel2.hide()
			tablabel3.show()
	
	if Input.is_key_pressed(KEY_1): tabstate = 1
	if Input.is_key_pressed(KEY_2): tabstate = 2
	if Input.is_key_pressed(KEY_3): tabstate = 3
	
	var modcolor = .5
	tab1.modulate = tabcolor1
	tab2.modulate = tabcolor2
	tab3.modulate = tabcolor3
	tab1.margin_top = tab1.margin_top + (tabmargin1 - tab1.margin_top) * .2
	tab2.margin_top = tab2.margin_top + (tabmargin2 - tab2.margin_top) * .2
	tab3.margin_top = tab3.margin_top + (tabmargin3 - tab3.margin_top) * .2
	
func clear_all():
	for child in box_mid.get_children():
		child.set_process(false)
		child.hide()
		
func _on_close_pressed():
	vis_state = VIS_ST_EXIT
	
func _on_back_pressed():
	match state:
		ST_MENU:
			vis_state = VIS_ST_EXIT
			overlay_black.show()
		ST_MENU_CONTROLS:
			_goto_menu()
		ST_MENU_CONTROLS_BIND:
			_goto_menu_controls()
		ST_MENU_AUDIO:
			_goto_menu()
	
func _goto_menu():
	state = ST_MENU
	tabstate = 1
	tablabel1.bbcode_text = "[color=#000000]Settings"
func _goto_menu_controls():
	state = ST_MENU_CONTROLS
	tabstate = 2
	tablabel2.bbcode_text = "[color=#000000]Controls"
func _goto_menu_controls_bind():
	state = ST_MENU_CONTROLS_BIND
	tabstate = 3
	tablabel3.bbcode_text = "[color=#000000]Binds"
func _goto_menu_audio():
	state = ST_MENU_AUDIO
	tabstate = 2
	tablabel2.bbcode_text = "[color=#000000]Audio"

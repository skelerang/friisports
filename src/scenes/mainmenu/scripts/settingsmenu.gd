extends Control

onready var overlay_black = $overlay_black
onready var box_top = $menu/top
onready var box_mid = $menu/mid
onready var box_bot = $menu/bottom

onready var tab1 = box_top.get_node("tab1")
onready var tab2 = box_top.get_node("tab2")
onready var tab3 = box_top.get_node("tab3")
onready var tablabel1 = tab1.get_node("Label")
onready var tablabel2 = tab2.get_node("Label")
onready var tablabel3 = tab3.get_node("Label")


var box_top_height = .16
var box_bottom_height = .2
enum {
	ST_IDLE
	ST_CLOSING
}

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


var visibility = 0
var state = ST_IDLE
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
		ST_IDLE:
			visibility = clamp(visibility + delta * 5, -1, 1)
			
		ST_CLOSING:
			visibility -= delta * 10
			if visibility < 0: queue_free()
			
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
	

func _on_but_close_pressed():
	state = ST_CLOSING
func _on_but_mainmenu_pressed():
	#warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/mainmenu.tscn")
func _on_but_exitgame_pressed():
	get_tree().quit()

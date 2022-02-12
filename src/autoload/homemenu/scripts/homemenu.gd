extends Control

onready var bg = $bg
onready var box_top = $box_top
onready var mid = $mid
onready var box_bottom = $box_bottom

var box_top_height = .16
var box_bottom_height = .2
enum {
	ST_IDLE
	ST_CLOSING
}

var visibility = 0
var state = ST_IDLE

func _ready():
	bg.modulate.a = 0
	mid.modulate.a = 0 # delay
	
	box_top.anchor_top = -box_top_height
	box_top.anchor_bottom = 0
	box_bottom.anchor_top = 1
	box_bottom.anchor_bottom = 1 + box_bottom_height

func _process(delta):
	match state:
		ST_IDLE:
			visibility = clamp(visibility + delta * 5, -1, 1)
			
		ST_CLOSING:
			visibility -= delta * 10
			if visibility < 0: queue_free()
			
	bg.modulate.a = visibility
	mid.modulate.a = visibility
	
	box_top.anchor_top = -box_top_height + (0 + box_top_height) * visibility
	box_top.anchor_bottom = 0 + (box_top_height - 0) * visibility
	box_bottom.anchor_top = 1 + (1 - box_bottom_height - 1) * visibility
	box_bottom.anchor_bottom = 1 + box_bottom_height + (1 - 1 + box_bottom_height) * visibility

func _on_but_close_pressed():
	state = ST_CLOSING
func _on_but_mainmenu_pressed():
	get_tree().change_scene("res://scenes/mainmenu.tscn")
func _on_but_exitgame_pressed():
	get_tree().quit()

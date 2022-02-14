extends Control

var ch_start = 1000
var ch_delay = 100
var ch_speed = .003
var bg_start = 3500
var bg_speed = .003
var end = 4000

onready var ch_grid = $channel_grid
onready var bg = $background1

var init_time

func _ready():
	Globals.cursor = false
	show()
	init_time = OS.get_ticks_msec()

func _process(_delta):
	var t = (OS.get_ticks_msec() - init_time) 
	
	var ch_t = clamp((t - ch_start) * ch_speed, 0, 6)
	ch_grid.get_child(0).modulate = Color(1,1,1,sin(ch_t))
	ch_grid.get_child(1).modulate = Color(1,1,1,sin(ch_t+ch_delay))
	ch_grid.get_child(2).modulate = Color(1,1,1,sin(ch_t+ch_delay*2))
	ch_grid.get_child(3).modulate = Color(1,1,1,sin(ch_t+ch_delay*3))
	
	ch_grid.get_child(4).modulate = Color(1,1,1,sin(ch_t+ch_delay))
	ch_grid.get_child(5).modulate = Color(1,1,1,sin(ch_t+ch_delay*2))
	ch_grid.get_child(6).modulate = Color(1,1,1,sin(ch_t+ch_delay*3))
	ch_grid.get_child(7).modulate = Color(1,1,1,sin(ch_t+ch_delay*4))

	ch_grid.get_child(8).modulate = Color(1,1,1,sin(ch_t+ch_delay*2))
	ch_grid.get_child(9).modulate = Color(1,1,1,sin(ch_t+ch_delay*3))
	ch_grid.get_child(10).modulate = Color(1,1,1,sin(ch_t+ch_delay*4))
	ch_grid.get_child(11).modulate = Color(1,1,1,sin(ch_t+ch_delay*5))
	
	bg.modulate = Color(1,1,1,(t-bg_start)*bg_speed)
	
	if t > end:
		get_parent().get_node("screen1").show()
		queue_free()

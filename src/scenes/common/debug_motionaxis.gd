extends Control

onready var select = $axisraw/VBoxContainer/controllerselect

# --- Raw Axis --- #
onready var bar0 = $axisraw/VBoxContainer/axis0
onready var bar1 = $axisraw/VBoxContainer/axis1
onready var bar2 = $axisraw/VBoxContainer/axis2
onready var bar3 = $axisraw/VBoxContainer/axis3

onready var bar4 = $axisraw/VBoxContainer/axis4
onready var bar5 = $axisraw/VBoxContainer/axis5
onready var bar6 = $axisraw/VBoxContainer/axis6
onready var bar7 = $axisraw/VBoxContainer/axis7

onready var bar8 = $axisraw/VBoxContainer/axis8
onready var bar9 = $axisraw/VBoxContainer/axis9
onready var bar10 = $axisraw/VBoxContainer/axis10
onready var bar11 = $axisraw/VBoxContainer/axis11

onready var bar12 = $axisraw/VBoxContainer/axis12
onready var bar13 = $axisraw/VBoxContainer/axis13
onready var bar14 = $axisraw/VBoxContainer/axis14
onready var bar15 = $axisraw/VBoxContainer/axis15

# --- Motion_accl --- #
onready var accl_xpos = $motion/xpos
onready var accl_xneg = $motion/xneg
onready var accl_ypos = $motion/ypos
onready var accl_yneg = $motion/yneg
onready var accl_zpos = $motion/zpos
onready var accl_zneg = $motion/zneg

var joy_id = 0

func _process(_delta):
	joy_id = select.get_selected_id()
	
	# --- Raw Axis --- #
	bar0.value = Input.get_joy_axis(joy_id,0)
	bar1.value = Input.get_joy_axis(joy_id,1)
	bar2.value = Input.get_joy_axis(joy_id,2)
	bar3.value = Input.get_joy_axis(joy_id,3)
	bar4.value = Input.get_joy_axis(joy_id,4)
	bar5.value = Input.get_joy_axis(joy_id,5)
	bar6.value = Input.get_joy_axis(joy_id,6)
	bar7.value = Input.get_joy_axis(joy_id,7)
	bar8.value = Input.get_joy_axis(joy_id,8)
	bar9.value = Input.get_joy_axis(joy_id,9)
	bar10.value = Input.get_joy_axis(joy_id,10)
	bar11.value = Input.get_joy_axis(joy_id,11)
	bar12.value = Input.get_joy_axis(joy_id,12)
	bar13.value = Input.get_joy_axis(joy_id,13)
	bar14.value = Input.get_joy_axis(joy_id,14)
	bar15.value = Input.get_joy_axis(joy_id,15)
	
	# --- Motion_accl --- #
	accl_xpos.value = Input.get_action_raw_strength("motion_accl_x+")
	accl_xneg.value = Input.get_action_raw_strength("motion_accl_x-")
	accl_ypos.value = Input.get_action_raw_strength("motion_accl_y+")
	accl_yneg.value = Input.get_action_raw_strength("motion_accl_y-")
	accl_zpos.value = -Input.get_action_raw_strength("motion_accl_z-") + .5
	accl_zneg.value = Input.get_action_raw_strength("motion_accl_z-") -.5


func _on_refreshbut_button_down():
	select.clear()
	for i in Input.get_connected_joypads():
		select.add_item(Input.get_joy_name(i), i)

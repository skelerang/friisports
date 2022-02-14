extends Control

var cursor = preload("res://autoload/cursor/tex_cursor.svg")

var speed = 1500

func _ready():
	Input.set_custom_mouse_cursor(cursor, 0, Vector2(23,6))

func _process(delta):
	if Globals.cursor:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		var input = Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down")  - Input.get_action_strength("ui_up")
		)
		var screensizefactor = get_viewport().size.length() / 1000
		var delta_mousepos = input * screensizefactor * speed * delta
		if (delta_mousepos):
			var newmousepos = Vector2(get_viewport().get_mouse_position() + delta_mousepos)
			newmousepos.x = clamp(newmousepos.x, 0, get_viewport().size.x - 1)
			newmousepos.y = clamp(newmousepos.y, 0, get_viewport().size.y - 1)
			get_viewport().warp_mouse(newmousepos)
		
		if Input.is_action_just_pressed("ui_accept"):
			var event = InputEventMouseButton.new()
			event.set_button_index(BUTTON_LEFT)
			event.pressed = true
			event.position = get_viewport().get_mouse_position()
			get_tree().input_event(event)
			
			event = InputEventMouseButton.new()
			event.set_button_index(BUTTON_LEFT)
			event.pressed = false
			event.position = get_viewport().get_mouse_position()
			get_tree().input_event(event)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

extends Control

onready var nohome_icon = $TextureRect

var state = 0

func _ready():
	nohome_icon.modulate.a = 0

func _process(delta):
	if state == 0:
		nohome_icon.modulate.a += delta
		if nohome_icon.modulate.a > 1:
			state = 1
	else:
		nohome_icon.modulate.a -= delta
		if nohome_icon.modulate.a < 0:
			queue_free()

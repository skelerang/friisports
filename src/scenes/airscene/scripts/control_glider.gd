extends KinematicBody

#var gravity = Vector3(0,-9.8,0)
var gravity = Vector3(0,-.8,0)
var velocity = Vector3(0,0,0)
var max_rot_h = 30 # degrees
var max_rot_v = 30 # degrees

var turn_speed = 1


onready var model = $glider

func _ready():
	velocity.z = -20

func _physics_process(delta):
	#velocity += gravity * delta
	#move_and_slide(velocity.rotated(rotation,), Vector3.UP)
	
	var input_h = Input.get_axis("airscene_glide_left", "airscene_glide_right")
	var input_v = Input.get_axis("airscene_glide_down", "airscene_glide_up")
	
	model.set_rotation_degrees(Vector3(-input_v * max_rot_v,0,-input_h * max_rot_h))
	
	rotate_y(-input_h * delta * turn_speed)
